-- 003_custos_promocoes.sql
-- Custo de cada produto (só o painel vê), tags e promoções.

-- 1. Custo fica em tabela separada: a tabela produtos é lida pelo site, o custo não pode vazar.
create table if not exists public.produto_custos (
  produto_id uuid primary key references public.produtos(id) on delete cascade,
  gramas numeric(8,2),            -- PLA, com purga
  horas numeric(6,2),             -- horas de máquina na A1
  insumos numeric(8,2) not null default 0,   -- argola, LED, ímã etc.
  fonte text,                     -- 'fatiador' ou 'suposição'
  atualizado_em timestamptz not null default now()
);
alter table public.produto_custos enable row level security;
create policy "só o painel vê custo" on public.produto_custos for all using (public.e_do_painel()) with check (public.e_do_painel());

-- Parâmetros do cálculo (uma linha). Espelha o _parametros-preco.json do vault.
create table if not exists public.parametros_custo (
  id int primary key default 1 check (id = 1),
  pla_kg numeric(8,2) not null default 120,
  hora_maquina numeric(8,2) not null default 0.67,
  refugo numeric(5,4) not null default 0.05,
  embalagem numeric(8,2) not null default 2.50,
  mao_obra_hora numeric(8,2) not null default 0,
  mao_obra_min int not null default 15,
  taxa_link numeric(5,4) not null default 0
);
insert into public.parametros_custo (id) values (1) on conflict do nothing;
alter table public.parametros_custo enable row level security;
create policy "só o painel vê parâmetros" on public.parametros_custo for select using (public.e_do_painel());
create policy "admin muda parâmetros" on public.parametros_custo for update using (public.e_admin()) with check (public.e_admin());

-- Custo e lucro calculados (só para o painel).
create or replace view public.produto_lucro with (security_invoker = true) as
select p.id, p.nome, p.preco,
  round(c.gramas * pc.pla_kg / 1000, 2) as material,
  round(c.horas * pc.hora_maquina, 2) as maquina,
  round((c.gramas * pc.pla_kg / 1000 + c.horas * pc.hora_maquina) * pc.refugo, 2) as refugo,
  pc.embalagem, c.insumos,
  round(pc.mao_obra_min / 60.0 * pc.mao_obra_hora, 2) as mao_obra,
  round((c.gramas * pc.pla_kg / 1000 + c.horas * pc.hora_maquina) * (1 + pc.refugo) + pc.embalagem + c.insumos + pc.mao_obra_min / 60.0 * pc.mao_obra_hora, 2) as custo_total,
  c.horas, c.fonte
from public.produtos p
join public.produto_custos c on c.produto_id = p.id
cross join public.parametros_custo pc;

-- 2. Tags dos produtos (Para a mãe, Fé, Natal, Sensorial...)
alter table public.produtos add column if not exists tags text[] not null default '{}';
alter table public.produtos add column if not exists selo text;
alter table public.produtos add column if not exists a_partir boolean not null default false;
alter table public.produtos add column if not exists grupos text[] not null default '{}';
create index if not exists produtos_tags_idx on public.produtos using gin (tags);

-- 3. Promoções
create table if not exists public.promocoes (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  tipo text not null check (tipo in ('percentual', 'valor')),
  valor numeric(8,2) not null check (valor > 0),
  alvo_tipo text not null check (alvo_tipo in ('produto', 'categoria', 'tag')),
  alvo_produto uuid references public.produtos(id) on delete cascade,
  alvo_categoria uuid references public.categorias(id) on delete cascade,
  alvo_tag text,
  inicio date not null,
  fim date not null check (fim >= inicio),
  pausada boolean not null default false,
  mostrar_riscado boolean not null default true,
  criado_em timestamptz not null default now()
);
alter table public.promocoes enable row level security;
create policy "site lê promoções ativas" on public.promocoes for select
  using ((not pausada and current_date between inicio and fim) or public.e_do_painel());
create policy "painel grava promoções" on public.promocoes for all using (public.e_do_painel()) with check (public.e_do_painel());

-- Preço que o site mostra hoje: o maior desconto entre as promoções ativas, terminado em ,90.
create or replace view public.produtos_preco_vigente with (security_invoker = true) as
select p.id, p.preco as preco_cheio,
  coalesce(min(greatest(0.90, floor(
    case when pr.tipo = 'percentual' then p.preco * (1 - pr.valor / 100) else p.preco - pr.valor end - 0.90) + 0.90)), p.preco) as preco_vigente,
  (array_agg(pr.nome order by case when pr.tipo = 'percentual' then p.preco * (1 - pr.valor / 100) else p.preco - pr.valor end))[1] as promocao
from public.produtos p
left join public.promocoes pr on not pr.pausada and current_date between pr.inicio and pr.fim
  and ((pr.alvo_tipo = 'produto' and pr.alvo_produto = p.id)
    or (pr.alvo_tipo = 'categoria' and pr.alvo_categoria = p.categoria_id)
    or (pr.alvo_tipo = 'tag' and pr.alvo_tag = any (p.tags)))
group by p.id, p.preco;
