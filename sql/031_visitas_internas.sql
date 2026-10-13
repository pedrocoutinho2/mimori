-- 031_visitas_internas.sql
-- Exclui do relatório as visitas da própria equipe (rede de casa e aparelhos marcados).
--
-- Duas camadas:
-- 1. Rede: o painel marca a rede atual como interna. Guardamos só o hash SHA-256 do IP,
--    nunca o IP em texto. Todo evento que chega de uma rede interna sai com interno = true.
-- 2. Aparelho: o site manda interno = true quando o navegador foi marcado
--    (abriu o painel ou o link ?interno=1).
--
-- Visitas anteriores a este SQL não têm como ser separadas: a tabela nunca guardou IP.

alter table public.eventos add column if not exists interno boolean not null default false;
create index if not exists eventos_interno_data_idx on public.eventos (interno, criado_em desc);

create table if not exists public.redes_internas (
  ip_hash text primary key,
  apelido text not null default 'Rede interna' check (char_length(apelido) <= 60),
  criado_em timestamptz not null default now(),
  visto_em timestamptz not null default now()
);
alter table public.redes_internas enable row level security;
drop policy if exists "painel lê redes internas" on public.redes_internas;
create policy "painel lê redes internas" on public.redes_internas for select using (public.e_do_painel());
drop policy if exists "painel apaga redes internas" on public.redes_internas;
create policy "painel apaga redes internas" on public.redes_internas for delete using (public.e_do_painel());

-- Hash do IP de quem está fazendo a requisição (lido dos cabeçalhos que o Supabase repassa).
create or replace function public.ip_hash_atual()
returns text language plpgsql stable security definer set search_path = public as $$
declare h json; ip text;
begin
  begin h := current_setting('request.headers', true)::json; exception when others then return null; end;
  if h is null then return null; end if;
  ip := coalesce(h->>'cf-connecting-ip', h->>'x-real-ip', split_part(coalesce(h->>'x-forwarded-for', ''), ',', 1));
  ip := nullif(trim(ip), '');
  if ip is null then return null; end if;
  return encode(sha256(convert_to(ip, 'UTF8')), 'hex');
end $$;
revoke all on function public.ip_hash_atual() from public, anon;

-- Marca o evento como interno quando vem de rede interna.
create or replace function public.eventos_marca_interno()
returns trigger language plpgsql security definer set search_path = public as $$
declare hh text;
begin
  if not new.interno then
    hh := public.ip_hash_atual();
    if hh is not null and exists (select 1 from public.redes_internas where ip_hash = hh) then
      new.interno := true;
      update public.redes_internas set visto_em = now() where ip_hash = hh;
    end if;
  end if;
  return new;
end $$;
drop trigger if exists eventos_marca_interno on public.eventos;
create trigger eventos_marca_interno before insert on public.eventos
  for each row execute function public.eventos_marca_interno();

-- Painel: marca a rede atual como interna.
create or replace function public.marcar_rede_interna(apelido text default 'Rede interna')
returns boolean language plpgsql security definer set search_path = public as $$
declare hh text := public.ip_hash_atual();
begin
  if not public.e_do_painel() then raise exception 'sem permissão'; end if;
  if hh is null then return false; end if;
  insert into public.redes_internas (ip_hash, apelido) values (hh, left(coalesce(nullif(trim(apelido), ''), 'Rede interna'), 60))
    on conflict (ip_hash) do update set apelido = excluded.apelido, visto_em = now();
  return true;
end $$;

-- Painel: a rede de onde estou agora já é interna?
create or replace function public.rede_atual_interna()
returns boolean language sql stable security definer set search_path = public as $$
  select public.e_do_painel() and exists (select 1 from public.redes_internas where ip_hash = public.ip_hash_atual());
$$;

revoke all on function public.marcar_rede_interna(text) from public, anon;
revoke all on function public.rede_atual_interna() from public, anon;
grant execute on function public.marcar_rede_interna(text) to authenticated;
grant execute on function public.rede_atual_interna() to authenticated;

-- Consultas prontas da 002 passam a ignorar visitas internas.
create or replace function public.relatorio_produtos(dias int default 30)
returns table (produto_id uuid, nome text, visitas bigint, na_lista bigint, no_whatsapp bigint)
language sql stable security definer set search_path = public as $$
  select p.id, p.nome,
    count(*) filter (where e.tipo = 'produto_visto'),
    count(*) filter (where e.tipo = 'lista_adicionou'),
    count(*) filter (where e.tipo = 'whatsapp_clique')
  from public.produtos p
  join public.eventos e on e.produto_id = p.id
  where e.criado_em >= now() - make_interval(days => dias) and not e.interno and public.e_do_painel()
  group by p.id, p.nome
  order by 3 desc;
$$;

create or replace function public.relatorio_funil(dias int default 30)
returns table (etapa text, sessoes bigint)
language sql stable security definer set search_path = public as $$
  select t.etapa, count(distinct e.sessao)
  from (values ('visita', 1), ('produto_visto', 2), ('lista_adicionou', 3), ('lista_enviou', 4)) as t(etapa, ordem)
  left join public.eventos e on e.tipo = t.etapa and not e.interno and e.criado_em >= now() - make_interval(days => dias)
  where public.e_do_painel()
  group by t.etapa, t.ordem
  order by t.ordem;
$$;
