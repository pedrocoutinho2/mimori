-- 038 · Preço e custo de produção da Estrela Sensorial e do Ovo de Dragão; embalagem padrão R$ 0,50 (16/10/2026)
-- APLICADO em 16/10/2026 pelo Pedro no SQL Editor (projeto ydnanmpqwbjzskovnhyh); páginas geradas e push feitos.
-- Só update e upsert; não apaga nada.
--
-- Decisões do Pedro (16/10/2026):
--   Estrela Sensorial Fidget: R$ 22,90 · Ovo de Dragão Fidget: R$ 28,90
--   Embalagem padrão passa a R$ 0,50 por pedido, sempre (50-decisoes/2026-10-16-mimori-embalagem-padrao-050)
-- Custo pelo print do fatiador (Bambu Studio, 16/10/2026), motor do vault (_parametros-preco.json de 16/10):
--   Estrela: 52,64 g, 2h05 (inclui 13m45s de timelapse). Produção sem MO R$ 8,23 · com MO R$ 11,63 · com embalagem R$ 12,13.
--            A R$ 22,90: lucro R$ 10,77 · R$ 5,17 por hora de máquina.
--   Ovo:     55,25 g PLA Silk, 4h04 (inclui 8m51s de timelapse). Produção sem MO R$ 10,09 · com MO R$ 13,49 · com embalagem R$ 13,99.
--            A R$ 28,90: lucro R$ 14,91 · R$ 3,67 por hora de máquina (abaixo do piso de R$ 5/h, decisão do Pedro).
-- Mão de obra: 10 min por peça (preparo 4 + acabamento 6, padrão da org) [CONFIRMAR].
-- [CONFIRMAR] slug: 'estrela-sensorial-fidget' é a Estrela do vault (estrela-fidget, MIM-ESTR01). Há também 'estrela-fidget-10-pontas' e 'estrela-do-mar-fidget', que não mudam.
-- Observação: a view produto_lucro usa parametros_custo.hora_maquina (1,18 desde o 014); o motor do vault está em R$ 0,60/h + energia (12/10).
-- O custo no painel pode sair diferente do acima até a hora de máquina do site ser alinhada.
begin;

update public.parametros_custo set embalagem = 0.50 where id = 1;

update public.produtos set preco = 22.90, atualizado_em = now() where slug = 'estrela-sensorial-fidget';
update public.produtos set preco = 28.90, atualizado_em = now() where slug = 'ovo-de-dragao-fidget';

-- opções (cores) com o mesmo preço do produto
update public.produto_opcoes o set preco = p.preco from public.produtos p
  where o.produto_id = p.id and p.slug in ('estrela-sensorial-fidget', 'ovo-de-dragao-fidget');

-- custo de produção no painel (fatiador)
insert into public.produto_custos (produto_id, gramas, horas, insumos, mao_obra_min, fonte)
  select p.id, v.g, v.h, 0, 10, 'fatiador'
  from (values ('estrela-sensorial-fidget', 52.64, 2.083), ('ovo-de-dragao-fidget', 55.25, 4.067)) as v(slug, g, h)
  join public.produtos p on p.slug = v.slug
  on conflict (produto_id) do update set gramas = excluded.gramas, horas = excluded.horas, insumos = excluded.insumos,
    mao_obra_min = excluded.mao_obra_min, fonte = excluded.fonte;

commit;

-- conferência
select p.slug, p.preco, l.custo_total, (select json_agg(o.preco) from public.produto_opcoes o where o.produto_id = p.id) opcoes
  from public.produtos p left join public.produto_lucro l on l.id = p.id
  where p.slug in ('estrela-sensorial-fidget', 'ovo-de-dragao-fidget');
