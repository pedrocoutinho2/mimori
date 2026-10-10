-- 016 · Vitrine e configuração no banco, e salvamento do produto numa transação só (10/10/2026)
--
-- Por quê: até aqui, prateleiras da home, datas especiais (temas), WhatsApp e fotos de categoria
-- moravam só em data/catalogo.json, e as prateleiras ligavam o produto pelo NOME. Renomear uma peça
-- no painel tirava a peça da home sem aviso, e mudar a vitrine exigia editar arquivo e subir no GitHub.
-- Agora tudo isso fica no Supabase, ligado pelo id do produto, e é editado no painel (aba Vitrine).
-- O salvamento do produto (dados, cores, kits e custo) passa a ser uma transação só, com trava contra
-- duas pessoas editando a mesma peça ao mesmo tempo.
--
-- Só acrescenta colunas, tabelas e funções. Não apaga nem altera dado existente.

-- 1. Coleções: prateleira da home ou data especial ------------------------------
alter table public.colecoes
  add column if not exists tipo text not null default 'prateleira',
  add column if not exists titulo text,
  add column if not exists texto text,
  add column if not exists link text,
  add column if not exists cta text,
  add column if not exists rotulo text,
  add column if not exists faixa text,
  add column if not exists inicio date,
  add column if not exists fim date,
  add column if not exists cor jsonb,
  add column if not exists publicado boolean not null default true,
  add column if not exists atualizado_em timestamptz not null default now();
do $$ begin
  alter table public.colecoes add constraint colecoes_tipo_ck check (tipo in ('prateleira', 'data'));
exception when duplicate_object then null; end $$;
drop trigger if exists colecoes_atualizado on public.colecoes;
create trigger colecoes_atualizado before update on public.colecoes for each row execute function public.tocar_atualizado_em();

-- 2. Foto da categoria ------------------------------------------------------------
alter table public.categorias add column if not exists foto text;

-- 3. Configuração do site (WhatsApp, redes, link do gamer) ------------------------
create table if not exists public.site_config (
  chave text primary key,
  valor text not null default '',
  atualizado_em timestamptz not null default now()
);
alter table public.site_config enable row level security;
drop policy if exists "site lê configuração" on public.site_config;
create policy "site lê configuração" on public.site_config for select using (true);
drop policy if exists "painel grava configuração" on public.site_config;
create policy "painel grava configuração" on public.site_config for all using (public.e_do_painel()) with check (public.e_do_painel());

-- 4. Carga inicial, a partir de data/catalogo.json ----------------------------------
insert into public.site_config (chave, valor) values ('whatsapp', '5521996237746') on conflict (chave) do nothing;
insert into public.site_config (chave, valor) values ('whatsappTxt', '(21) 99623-7746') on conflict (chave) do nothing;
insert into public.site_config (chave, valor) values ('instagram', 'mimori3d') on conflict (chave) do nothing;
insert into public.site_config (chave, valor) values ('tiktok', 'mimori3d') on conflict (chave) do nothing;
insert into public.site_config (chave, valor) values ('gamer', 'https://mimori3d.com.br/gamer/') on conflict (chave) do nothing;
update public.categorias set foto = 'assets/fotos/categoria-religiosos.jpg' where slug = 'produtos-religiosos' and foto is null;
update public.categorias set foto = 'assets/fotos/categoria-vasos.jpg' where slug = 'vasos-de-planta' and foto is null;
update public.categorias set foto = 'assets/fotos/categoria-chaveiros.jpg' where slug = 'chaveiros' and foto is null;
update public.categorias set foto = 'assets/fotos/categoria-casa.jpg' where slug = 'casa-e-organizacao' and foto is null;
update public.categorias set foto = 'assets/fotos/categoria-jogos.jpg' where slug = 'jogos-e-fidget' and foto is null;
update public.categorias set foto = 'assets/fotos/categoria-salao.jpg' where slug = 'brindes-para-salao' and foto is null;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, link) values ('escolhas', 'Escolhas da Mimori', 'prateleira', 1, 'Escolhas da Mimori', 'As peças que a gente mais ama, pra você começar por elas! 💜', null) on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Porta Terço Bandeja Ore e Confie', 0), ('Vaso Coração com Mãos', 1), ('Porta Chaves Arco Canelado com Prateleira', 2), ('Kit Ore e Confie com Bandeja e Porta Vela', 3), ('Luminária Jesus Escada para o Céu', 4), ('Nossa Senhora do Manto', 5), ('Chaveiro Câmera Instantânea', 6), ('Estrela do Mar Fidget', 7)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'escolhas'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, link) values ('religiosos', 'Pro seu cantinho de oração', 'prateleira', 2, 'Pro seu cantinho de oração', 'Nossa Senhora, porta-terço, oratório e luminária pra deixar a sua fé sempre por perto. 🙏', 'produtos-religiosos') on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Nossa Senhora do Manto', 0), ('Porta Terço Bandeja Ore e Confie', 1), ('Porta Terço Nossa Senhora Oratório', 2), ('Kit Ore e Confie com Bandeja e Porta Vela', 3), ('Mini Jesus Sentado', 4), ('Letreiro Ore e Confie', 5), ('Luminária Jesus Escada para o Céu', 6)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'religiosos'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, link) values ('vasos', 'Um vaso pra cada planta', 'prateleira', 3, 'Um vaso pra cada planta', 'Bichinho, moderno, autoirrigável ou com pratinho: modelos pra sua planta ficar com a sua cara! 🪴', 'vasos-de-planta') on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Vaso Coruja', 0), ('Vaso Gatinho Fofo', 1), ('Vaso Dragão Dormindo', 2), ('Vaso Japandi Autoirrigável', 3), ('Vaso Ninho Bicolor', 4), ('Vaso Gato', 5), ('Vaso Vaquinha Peluda', 6), ('Vaso Coração com Mãos', 7), ('Vaso Gotejamento HexaRain', 8), ('Vaso Gato Sentado', 9)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'vasos'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, link) values ('ate35', 'Presentes até R$ 35', 'prateleira', 4, 'Presentes até R$ 35', 'Pra lembrancinha, amigo secreto e visita.', null) on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Chaveiro Câmera Instantânea', 0), ('Mini Jesus Sentado', 1), ('Nossa Senhora do Manto', 2), ('Organizador de Pratos Vertical', 3), ('Porta Terço Nossa Senhora Oratório', 4), ('Letreiro Ore e Confie', 5)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'ate35'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, rotulo, faixa, cta, link, inicio, fim, cor) values ('criancas', 'Presente que vira brincadeira', 'data', 5, 'Presente que vira brincadeira', 'Brinquedos sensoriais para mexer, girar e acalmar, ideais para crianças e adultos com TDAH, TEA ou ansiedade que buscam foco e relaxamento.', 'Dia das Crianças, 12/10', 'Dia das Crianças é 12/10.', 'Ver brinquedos sensoriais', 'datas-especiais#criancas', '2026-09-20', '2026-10-12', '{"fundo": "#E7E2F3", "texto": "#241F2E", "titulo": "#382B55", "selo": "#FFFFFF", "seloTexto": "#4A396F", "cta": "#6E5B98", "ctaTexto": "#FFFFFF"}'::jsonb) on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Estrela do Mar Fidget', 0), ('Ovo de Dragão Fidget', 1), ('Estrela Sensorial Fidget', 2), ('Cubo Infinito Fidget', 3), ('Giroscópio Fidget 4 Anéis', 4), ('Câmbio de Marchas Fidget', 5), ('Anéis Táteis Fidget', 6), ('Medusa Fidget Articulada', 7), ('Cone Espiral Fidget', 8), ('Cone Impossível Fidget', 9), ('Bola Twisty Fidget', 10), ('Estrela Fidget 10 Pontas', 11), ('Tecido Sensorial 3D', 12), ('Minhoca Morf Fidget', 13), ('Jogo da Memória das Cenouras', 14)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'criancas'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, rotulo, faixa, cta, link, inicio, fim, cor) values ('halloween', 'Assustadoramente fofo', 'data', 6, 'Assustadoramente fofo', 'Gato, coruja e dragão pra deixar a estante e a mesa da festa no clima! 🎃 E ficam lindos o ano todo.', 'Halloween, 31/10', 'Halloween é 31/10.', 'Ver a decoração de Halloween', 'datas-especiais#halloween', '2026-10-13', '2026-10-31', '{"fundo": "#F28A2E", "texto": "#241F2E", "titulo": "#1B1528", "selo": "#1B1528", "seloTexto": "#FFFFFF", "cta": "#1B1528", "ctaTexto": "#FFFFFF"}'::jsonb) on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Vaso Gato', 0), ('Vaso Coruja', 1), ('Vaso Dragão Dormindo', 2), ('Gato Derrubando Vaso', 3)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'halloween'
  on conflict do nothing;
insert into public.colecoes (slug, nome, tipo, ordem, titulo, texto, rotulo, faixa, cta, link, inicio, fim, cor) values ('natal', 'Presente de Natal com significado', 'data', 7, 'Presente de Natal com significado', 'Luminária, Mini Jesus e peças de fé pra presentear a família toda! 🎄 Os pedidos de Natal fecham em [data-limite] pra chegar a tempo.', 'Natal, 25/12', 'Natal é 25/12.', 'Ver presentes de Natal', 'datas-especiais#natal', '2026-11-01', '2026-12-25', '{"fundo": "#B3262D", "texto": "#FFFFFF", "titulo": "#FFFFFF", "selo": "#FFFFFF", "seloTexto": "#B3262D", "cta": "#FFFFFF", "ctaTexto": "#B3262D"}'::jsonb) on conflict (slug) do nothing;
insert into public.colecao_produtos (colecao_id, produto_id, ordem)
  select c.id, p.id, v.o from (values ('Luminária Jesus Escada para o Céu', 0), ('Mini Jesus Sentado', 1), ('Kit Ore e Confie com Bandeja e Porta Vela', 2), ('Nossa Senhora do Manto', 3)) v(n, o)
  join public.produtos p on p.nome = v.n join public.colecoes c on c.slug = 'natal'
  on conflict do nothing;

-- 5. Salvar produto numa transação só ----------------------------------------------
-- Recebe o produto inteiro (dados, preço por quantidade, cores, kits e custo). Se qualquer parte falhar, nada muda.
-- p_versao: o atualizado_em que o painel tinha ao abrir o produto. Se alguém salvou depois,
-- a função recusa com 'conflito' em vez de sobrescrever a alteração da outra pessoa.
create or replace function public.salvar_produto(p jsonb, p_versao timestamptz default null)
returns table (id uuid, atualizado_em timestamptz)
language plpgsql security invoker set search_path = public as $$
declare
  v_id uuid := nullif(p->>'id', '')::uuid;
  v_atual timestamptz;
begin
  if not public.e_do_painel() then raise exception 'sem acesso ao painel'; end if;
  if v_id is not null then
    select pr.atualizado_em into v_atual from public.produtos pr where pr.id = v_id for update;
    if not found then raise exception 'produto não encontrado'; end if;
    if p_versao is not null and v_atual is distinct from p_versao then
      raise exception 'conflito: este produto foi alterado por outra pessoa depois que você abriu. Feche, abra de novo e refaça a alteração.';
    end if;
    update public.produtos set
      nome = p->>'nome', slug = p->>'slug', sku = nullif(p->>'sku', ''), categoria_id = (p->>'categoria_id')::uuid,
      preco = (p->>'preco')::numeric, selo = nullif(p->>'selo', ''), descricao = coalesce(p->>'descricao', ''),
      publicado = coalesce((p->>'publicado')::boolean, false), a_partir = coalesce((p->>'a_partir')::boolean, false),
      tags = coalesce(array(select jsonb_array_elements_text(p->'tags')), '{}'),
      faixas = case when p ? 'faixas' then coalesce(p->'faixas', '[]'::jsonb) else faixas end,
      faixa_consulta = case when p ? 'faixa_consulta' then nullif(p->>'faixa_consulta', '')::int else faixa_consulta end
    where produtos.id = v_id;
  else
    insert into public.produtos (nome, slug, sku, categoria_id, preco, selo, descricao, publicado, a_partir, tags, faixas, faixa_consulta)
    values (p->>'nome', p->>'slug', nullif(p->>'sku', ''), (p->>'categoria_id')::uuid, (p->>'preco')::numeric, nullif(p->>'selo', ''),
      coalesce(p->>'descricao', ''), coalesce((p->>'publicado')::boolean, false), coalesce((p->>'a_partir')::boolean, false),
      coalesce(array(select jsonb_array_elements_text(p->'tags')), '{}'), coalesce(p->'faixas', '[]'::jsonb), nullif(p->>'faixa_consulta', '')::int)
    returning produtos.id into v_id;
  end if;

  delete from public.variacoes where produto_id = v_id;
  insert into public.variacoes (produto_id, cor, ordem)
    select v_id, x.cor, x.o - 1 from jsonb_array_elements_text(coalesce(p->'cores', '[]')) with ordinality x(cor, o);

  delete from public.produto_opcoes where produto_id = v_id;
  insert into public.produto_opcoes (produto_id, nome, preco, ordem)
    select v_id, x.e->>'nome', (x.e->>'preco')::numeric, x.o - 1 from jsonb_array_elements(coalesce(p->'opcoes', '[]')) with ordinality x(e, o);

  if p ? 'custo' then
    insert into public.produto_custos (produto_id, gramas, horas, insumos, mao_obra_min, fonte, atualizado_em)
    values (v_id, (p->'custo'->>'gramas')::numeric, (p->'custo'->>'horas')::numeric, coalesce((p->'custo'->>'insumos')::numeric, 0),
      (p->'custo'->>'mao_obra_min')::int, p->'custo'->>'fonte', now())
    on conflict (produto_id) do update set gramas = excluded.gramas, horas = excluded.horas, insumos = excluded.insumos,
      mao_obra_min = excluded.mao_obra_min, fonte = excluded.fonte, atualizado_em = now();
  end if;

  return query select pr.id, pr.atualizado_em from public.produtos pr where pr.id = v_id;
end $$;
grant execute on function public.salvar_produto(jsonb, timestamptz) to authenticated;

-- 6. Salvar coleção (prateleira ou data) numa transação só ---------------------------
create or replace function public.salvar_colecao(c jsonb)
returns uuid language plpgsql security invoker set search_path = public as $$
declare v_id uuid := nullif(c->>'id', '')::uuid;
begin
  if not public.e_do_painel() then raise exception 'sem acesso ao painel'; end if;
  if v_id is null then
    insert into public.colecoes (slug, nome, tipo, ordem) values (c->>'slug', c->>'titulo', coalesce(c->>'tipo', 'prateleira'), coalesce((c->>'ordem')::int, 99))
    returning id into v_id;
  end if;
  update public.colecoes set
    nome = c->>'titulo', titulo = c->>'titulo', texto = nullif(c->>'texto', ''), link = nullif(c->>'link', ''), cta = nullif(c->>'cta', ''),
    rotulo = nullif(c->>'rotulo', ''), faixa = nullif(c->>'faixa', ''), inicio = nullif(c->>'inicio', '')::date, fim = nullif(c->>'fim', '')::date,
    publicado = coalesce((c->>'publicado')::boolean, true), ordem = coalesce((c->>'ordem')::int, ordem),
    cor = case when c ? 'cor' then c->'cor' else cor end
  where id = v_id;
  delete from public.colecao_produtos where colecao_id = v_id;
  insert into public.colecao_produtos (colecao_id, produto_id, ordem)
    select v_id, (x.e)::uuid, x.o - 1 from jsonb_array_elements_text(coalesce(c->'itens', '[]')) with ordinality x(e, o);
  return v_id;
end $$;
grant execute on function public.salvar_colecao(jsonb) to authenticated;

