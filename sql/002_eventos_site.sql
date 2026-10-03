-- 002_eventos_site.sql
-- Registro de eventos do site para os relatórios do painel.
-- Sem dado pessoal: só um id de sessão aleatório, gerado no navegador, sem nome, e-mail, IP ou telefone.

create table if not exists public.eventos (
  id bigint generated always as identity primary key,
  tipo text not null check (tipo in ('visita', 'produto_visto', 'lista_adicionou', 'lista_enviou', 'whatsapp_clique', 'busca')),
  pagina text,                    -- ex.: /, /vasos-de-planta, /produtos-religiosos/kit-ore-e-confie
  produto_id uuid references public.produtos(id) on delete set null,
  botao text,                     -- de onde veio o clique no WhatsApp: lista, produto, brindes, personalizados, busca
  termo text,                     -- busca
  resultados int,                 -- busca: quantos produtos voltaram (0 = sem resultado)
  origem text,                    -- instagram, google, whatsapp, shopee, direto (de utm_source ou do referrer)
  sessao text not null,           -- id aleatório da sessão, sem dado pessoal
  criado_em timestamptz not null default now()
);

create index if not exists eventos_tipo_data_idx on public.eventos (tipo, criado_em desc);
create index if not exists eventos_produto_idx on public.eventos (produto_id, tipo);

alter table public.eventos enable row level security;

-- O site grava (anônimo), mas não lê. Só o painel lê.
create policy "site registra eventos" on public.eventos for insert to anon, authenticated
  with check (char_length(coalesce(termo, '')) <= 80 and char_length(coalesce(pagina, '')) <= 200);
create policy "painel lê eventos" on public.eventos for select using (public.e_do_painel());

-- Resumo por produto no período (usado na tabela "Produtos" dos relatórios).
create or replace function public.relatorio_produtos(dias int default 30)
returns table (produto_id uuid, nome text, visitas bigint, na_lista bigint, no_whatsapp bigint)
language sql stable security definer set search_path = public as $$
  select p.id, p.nome,
    count(*) filter (where e.tipo = 'produto_visto'),
    count(*) filter (where e.tipo = 'lista_adicionou'),
    count(*) filter (where e.tipo = 'whatsapp_clique')
  from public.produtos p
  join public.eventos e on e.produto_id = p.id
  where e.criado_em >= now() - make_interval(days => dias) and public.e_do_painel()
  group by p.id, p.nome
  order by 3 desc;
$$;

-- Funil do período.
create or replace function public.relatorio_funil(dias int default 30)
returns table (etapa text, sessoes bigint)
language sql stable security definer set search_path = public as $$
  select t.etapa, count(distinct e.sessao)
  from (values ('visita', 1), ('produto_visto', 2), ('lista_adicionou', 3), ('lista_enviou', 4)) as t(etapa, ordem)
  left join public.eventos e on e.tipo = t.etapa and e.criado_em >= now() - make_interval(days => dias)
  where public.e_do_painel()
  group by t.etapa, t.ordem
  order by t.ordem;
$$;
