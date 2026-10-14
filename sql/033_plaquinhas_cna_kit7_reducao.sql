-- 033 · Kit Plaquinhas de Pintar Monstrinhos CNA · redução de tamanho e preço novo
-- 13/10/2026 · decisão do Pedro (opção 2)
--  * Plaquinhas reduzidas para 7,5 a 10 cm, 2 mm de espessura
--    (fatiador: 32,01 g, 1h29, 1 troca de filamento)
--  * Custo por kit: R$ 5,17 de produção sem MO, R$ 6,57 com MO, R$ 6,97 com saquinho
--  * Preço: 1 a 9 R$ 15,90 · 10 a 49 R$ 13,90 · 50 a 99 R$ 11,90 · 100+ a consultar
--  * Nome: "Kit Plaquinhas de Pintar Monstrinhos CNA" (slug mantido)
-- Aplicado no banco em 14/10/2026 00:00. Só update; não apaga nada.
begin;

update public.produtos set
  nome = 'Kit Plaquinhas de Pintar Monstrinhos CNA',
  preco = 15.90,
  a_partir = false,
  faixas = '[{"min":10,"preco":13.9},{"min":50,"preco":11.9}]'::jsonb,
  faixa_consulta = 100,
  atualizado_em = now(),
  descricao = replace(descricao,
    'Tamanho: de 8 a 12 cm de altura, conforme o monstrinho
Peso: aproximadamente 43 g por kit',
    'Tamanho: de 7,5 a 10 cm de altura, conforme o monstrinho
Espessura: 2 mm
Peso: aproximadamente 32 g por kit')
where slug = 'plaquinhas-de-pintar-monstrinhos-cna';

update public.produto_custos set
  gramas = 32.01, horas = 1.48, insumos = 0, mao_obra_min = 4, fonte = 'fatiador', atualizado_em = now()
where produto_id = (select id from public.produtos where slug = 'plaquinhas-de-pintar-monstrinhos-cna');

commit;
