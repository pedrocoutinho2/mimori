-- 001_catalogo_site.sql
-- Catálogo do site mimori3d.com.br e acesso ao painel admin.
-- Aplicar no SQL Editor do projeto Supabase do site (projeto próprio, separado do Make3Lab).
-- Senhas não entram aqui: os usuários são criados pelo Supabase Auth (painel do Supabase ou convite).

-- 1. Tabelas -------------------------------------------------------------

create table if not exists public.categorias (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  nome text not null,
  ordem int not null default 0,
  criado_em timestamptz not null default now()
);

create table if not exists public.produtos (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  sku text unique,
  nome text not null,
  categoria_id uuid references public.categorias(id) on delete set null,
  preco numeric(10,2),
  descricao text,
  publicado boolean not null default false,
  destaque boolean not null default false,
  ordem int not null default 0,
  criado_em timestamptz not null default now(),
  atualizado_em timestamptz not null default now()
);

create table if not exists public.produto_fotos (
  id uuid primary key default gen_random_uuid(),
  produto_id uuid not null references public.produtos(id) on delete cascade,
  caminho text not null,                       -- caminho no bucket "produtos"
  tipo text not null default 'real' check (tipo in ('real', 'criador', 'excecao')),
  ordem int not null default 0,
  criado_em timestamptz not null default now()
);

create table if not exists public.produto_videos (
  id uuid primary key default gen_random_uuid(),
  produto_id uuid not null references public.produtos(id) on delete cascade,
  caminho text not null,
  ordem int not null default 0,
  criado_em timestamptz not null default now()
);

create table if not exists public.variacoes (
  id uuid primary key default gen_random_uuid(),
  produto_id uuid not null references public.produtos(id) on delete cascade,
  cor text not null,
  sku text unique,
  ordem int not null default 0
);

create table if not exists public.colecoes (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  nome text not null,
  ordem int not null default 0
);

create table if not exists public.colecao_produtos (
  colecao_id uuid not null references public.colecoes(id) on delete cascade,
  produto_id uuid not null references public.produtos(id) on delete cascade,
  ordem int not null default 0,
  primary key (colecao_id, produto_id)
);

-- Quem entra no painel. Só o e-mail e o papel; a senha fica no Supabase Auth.
create table if not exists public.painel_usuarios (
  user_id uuid primary key references auth.users(id) on delete cascade,
  email text not null unique,
  nome text,
  papel text not null default 'editor' check (papel in ('admin', 'editor')),
  criado_em timestamptz not null default now()
);

create index if not exists produtos_categoria_idx on public.produtos (categoria_id);
create index if not exists fotos_produto_idx on public.produto_fotos (produto_id, ordem);

-- 2. Funções de acesso ------------------------------------------------------

create or replace function public.e_do_painel() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.painel_usuarios where user_id = auth.uid());
$$;

create or replace function public.e_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.painel_usuarios where user_id = auth.uid() and papel = 'admin');
$$;

create or replace function public.tocar_atualizado_em() returns trigger
language plpgsql set search_path = public as $$ begin new.atualizado_em = now(); return new; end $$;

drop trigger if exists produtos_atualizado on public.produtos;
create trigger produtos_atualizado before update on public.produtos
  for each row execute function public.tocar_atualizado_em();

-- 3. RLS ---------------------------------------------------------------------

alter table public.categorias enable row level security;
alter table public.produtos enable row level security;
alter table public.produto_fotos enable row level security;
alter table public.produto_videos enable row level security;
alter table public.variacoes enable row level security;
alter table public.colecoes enable row level security;
alter table public.colecao_produtos enable row level security;
alter table public.painel_usuarios enable row level security;

-- Leitura pública: o site lê só o que está publicado.
create policy "site lê categorias" on public.categorias for select using (true);
create policy "site lê coleções" on public.colecoes for select using (true);
create policy "site lê produtos publicados" on public.produtos for select using (publicado or public.e_do_painel());
create policy "site lê fotos publicadas" on public.produto_fotos for select
  using (exists (select 1 from public.produtos p where p.id = produto_id and (p.publicado or public.e_do_painel())));
create policy "site lê vídeos publicados" on public.produto_videos for select
  using (exists (select 1 from public.produtos p where p.id = produto_id and (p.publicado or public.e_do_painel())));
create policy "site lê variações publicadas" on public.variacoes for select
  using (exists (select 1 from public.produtos p where p.id = produto_id and (p.publicado or public.e_do_painel())));
create policy "site lê coleção e produto" on public.colecao_produtos for select using (true);

-- Escrita: só quem é do painel (admin ou editor).
create policy "painel grava categorias" on public.categorias for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava coleções" on public.colecoes for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava produtos" on public.produtos for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava fotos" on public.produto_fotos for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava vídeos" on public.produto_videos for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava variações" on public.variacoes for all using (public.e_do_painel()) with check (public.e_do_painel());
create policy "painel grava coleção e produto" on public.colecao_produtos for all using (public.e_do_painel()) with check (public.e_do_painel());

-- Usuários do painel: todos do painel veem a lista; só admin muda.
create policy "painel vê usuários" on public.painel_usuarios for select using (public.e_do_painel());
create policy "admin muda usuários" on public.painel_usuarios for all using (public.e_admin()) with check (public.e_admin());

-- 4. Storage: fotos e vídeos ------------------------------------------------

insert into storage.buckets (id, name, public) values ('produtos', 'produtos', true)
  on conflict (id) do nothing;

create policy "site lê arquivos de produto" on storage.objects for select using (bucket_id = 'produtos');
create policy "painel sobe arquivos" on storage.objects for insert with check (bucket_id = 'produtos' and public.e_do_painel());
create policy "painel troca arquivos" on storage.objects for update using (bucket_id = 'produtos' and public.e_do_painel());
create policy "painel apaga arquivos" on storage.objects for delete using (bucket_id = 'produtos' and public.e_do_painel());

-- 5. Dados iniciais -----------------------------------------------------------

insert into public.categorias (slug, nome, ordem) values
  ('produtos-religiosos', 'Religiosos', 1),
  ('vasos-de-planta', 'Vasos', 2),
  ('chaveiros', 'Chaveiros e lembrancinhas', 3),
  ('casa-e-organizacao', 'Casa e organização', 4),
  ('jogos-e-fidget', 'Jogos e fidget', 5)
on conflict (slug) do nothing;

-- 6. Primeiros administradores -------------------------------------------------
-- Rodar DEPOIS de criar as duas contas em Authentication > Users (Add user ou Invite).
-- Este bloco não cria conta nem senha: só dá acesso de admin a quem já existe no Auth.
insert into public.painel_usuarios (user_id, email, nome, papel)
select id, email, 'Pedro', 'admin' from auth.users where email = 'pedrocoutinho_@live.com'
on conflict (user_id) do update set papel = 'admin';

insert into public.painel_usuarios (user_id, email, nome, papel)
select id, email, 'Kamilla', 'admin' from auth.users where email = 'miguezkamilla@gmail.com'
on conflict (user_id) do update set papel = 'admin';
