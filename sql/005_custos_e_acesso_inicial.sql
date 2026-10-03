-- 005_custos_e_acesso_inicial.sql
-- Custos de partida (peso e tempo) para o painel aplicar depois da importação, e acesso de administrador automático para o Pedro e a Kamilla quando a conta for criada no Supabase Auth.

create table if not exists public.custos_iniciais (slug text primary key, gramas numeric(8,2), horas numeric(6,2), fonte text);
alter table public.custos_iniciais enable row level security;
create policy "só o painel vê custos iniciais" on public.custos_iniciais for select using (public.e_do_painel());
insert into public.custos_iniciais (slug, gramas, horas, fonte) values
('nossa-senhora-do-manto', 25, 1.2, 'suposição'),
('porta-terco-bandeja-ore-e-confie', 110, 6, 'suposição'),
('kit-ore-e-confie-com-bandeja-e-porta-vela', 146.64, 5.79, 'fatiador'),
('letreiro-ore-e-confie', 61.86, 2.87, 'fatiador'),
('mini-jesus-sentado', 23, 0.6, 'suposição'),
('luminaria-jesus-escada-para-o-ceu', 90.14, 4.5, 'suposição'),
('vaso-coruja', 37.0, 1.42, 'suposição'),
('vaso-ninho-bicolor', 131.0, 3.71, 'suposição'),
('vaso-inflado', 122.0, 5.01, 'suposição'),
('vaso-moderno-drift-com-prato', 100.0, 5.42, 'suposição'),
('vaso-poligonal-com-prato', 156.0, 7.4, 'suposição'),
('vaso-gato-sentado', 132.0, 5.34, 'suposição'),
('vaso-gatinho-fofo', 70.0, 2.81, 'suposição'),
('vaso-gato-mini', 70.0, 2.1, 'suposição'),
('gato-derrubando-vaso', 11.0, 0.58, 'suposição'),
('vaso-gato', 95.0, 2.9, 'suposição'),
('vaso-dino', 107.0, 3.12, 'suposição'),
('vaso-dragao-dormindo', 123.0, 4.12, 'suposição'),
('vaso-elefante', 120.0, 3.8, 'suposição'),
('vaso-ourico', 80.0, 3.62, 'suposição'),
('vaso-cachorro-salsicha', 56.0, 2.48, 'suposição'),
('vaso-vaquinha-peluda', 42.0, 2.19, 'suposição'),
('vaso-zuki-paz-e-amor', 63.0, 2.25, 'suposição'),
('vaso-no-balanco', 112.0, 5.82, 'suposição'),
('vaso-leitora-aconchego', 57.0, 2.08, 'suposição'),
('vaso-menina-lendo', 61.0, 2.1, 'suposição'),
('vaso-pensador', 59.0, 2.7, 'suposição'),
('vaso-de-parede-rosto-de-mulher', 74.0, 3.21, 'suposição'),
('vaso-xicara-barista', 42.0, 1.46, 'suposição'),
('vaso-carinha-feliz-mini', 65.0, 2.1, 'suposição'),
('vaso-arvore-espiral', 82.0, 3.75, 'suposição'),
('vaso-autoirrigavel-com-indicador-de-agua', 193.0, 5.32, 'suposição'),
('vaso-canelado-curvo', 99.0, 3.1, 'suposição'),
('vaso-canelado-redondo', 83.0, 3.64, 'suposição'),
('vaso-com-pes', 77.0, 3.57, 'suposição'),
('vaso-coracao-com-maos', 45.0, 1.67, 'suposição'),
('vaso-espiral-afunilado', 79.0, 4.09, 'suposição'),
('vaso-gotejamento-hexarain', 332.0, 7.11, 'suposição'),
('vaso-japandi-autoirrigavel', 238.0, 8.23, 'suposição'),
('vaso-kinetic-com-prato', 149.0, 8.3, 'suposição'),
('vaso-papel-amassado-com-prato', 185.0, 5.71, 'suposição'),
('vaso-com-prato-12-cm', 125.0, 5.99, 'suposição'),
('vaso-quadrado-com-prato', 145.0, 4.57, 'suposição'),
('vaso-wabi-sabi-autoirrigavel', 207.0, 3.03, 'suposição'),
('chaveiro-camera-porta-foto-3x4', 170.25, 5.92, 'fatiador'),
('porta-chaves-arco-canelado-com-prateleira', 187.44, 5.25, 'fatiador'),
('estrela-do-mar-fidget', 45, 3, 'suposição')
on conflict (slug) do nothing;

create or replace function public.aplicar_custos_iniciais() returns int
language plpgsql security definer set search_path = public as $$
declare n int;
begin
  if not public.e_admin() then raise exception 'só administrador'; end if;
  insert into public.produto_custos (produto_id, gramas, horas, fonte)
  select p.id, c.gramas, c.horas, c.fonte from public.custos_iniciais c join public.produtos p on p.slug = c.slug
  on conflict (produto_id) do nothing;
  get diagnostics n = row_count;
  return n;
end $$;

create or replace function public.dar_acesso_inicial() returns trigger
language plpgsql security definer set search_path = public as $$
begin
  if lower(new.email) = 'pedrocoutinho_@live.com' then
    insert into public.painel_usuarios (user_id, email, nome, papel) values (new.id, lower(new.email), 'Pedro', 'admin') on conflict (user_id) do nothing;
  elsif lower(new.email) = 'miguezkamilla@gmail.com' then
    insert into public.painel_usuarios (user_id, email, nome, papel) values (new.id, lower(new.email), 'Kamilla', 'admin') on conflict (user_id) do nothing;
  end if;
  return new;
end $$;
drop trigger if exists acesso_inicial_painel on auth.users;
create trigger acesso_inicial_painel after insert on auth.users for each row execute function public.dar_acesso_inicial();
