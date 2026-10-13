-- 028 · Preços dos chaveiros CNA, versão 2 (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 028_precos_chaveiros_cna_v2), decisão do Pedro na conversa.
-- Só update; não apaga nada. Substitui os preços dos chaveiros do 022.
--
-- Faixas: 1 a 9 / 10 a 49 / 50 a 99 / 100+ a consultar, sem embalagem, hora de máquina R$ 0,60 (vida útil 10.000 h).
--  * Giratório:  R$ 14,90 / 9,90 / 7,90. Custo com MO R$ 9,43 (1 un) / 4,28 / 4,02 por unidade.
--    Mesa cheia de 20 pelo fatiador: 3 placas, 267,33 g, 18h50.
--    A R$ 7,90 fica abaixo do piso de R$ 5/h (cerca de R$ 4,10/h), aceito pelo Pedro "por enquanto".
--  * Monstrinho: R$ 6,90 / 4,90 / 3,90. Custo com MO R$ 3,29 (1 un, estimado) / 1,74 / 1,51 por unidade.
--    Placa de 15 pelo fatiador: 51,82 g, 4h46.
-- Decisão: Second Brain/50-decisoes/2026-10-12-mimori-precos-chaveiros-cna.md
begin;

update public.produtos set preco = 14.90, a_partir = false,
  faixas = '[{"min":10,"preco":9.9},{"min":50,"preco":7.9}]'::jsonb, faixa_consulta = 100, atualizado_em = now()
  where slug = 'chaveiro-giratorio-cna';
update public.produtos set preco = 6.90, a_partir = false,
  faixas = '[{"min":10,"preco":4.9},{"min":50,"preco":3.9}]'::jsonb, faixa_consulta = 100, atualizado_em = now()
  where slug = 'chaveiro-monstrinho-cna';

-- opções de monstrinho com o mesmo preço do produto
update public.produto_opcoes o set preco = p.preco from public.produtos p
  where o.produto_id = p.id and p.slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');

-- texto de preço nas descrições: consulta passa de 50 para 100
update public.produtos set descricao = replace(descricao,
  'A partir de 10 unidades o preço baixa, e acima de 50 a gente combina com você no WhatsApp.',
  'A partir de 10 unidades o preço baixa, e baixa de novo a partir de 50. Acima de 100, a gente combina com você no WhatsApp.')
  where slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');

-- custo no painel: por unidade, em mesa cheia, pelo fatiador
update public.produto_custos c set gramas = 13.37, horas = 0.942, insumos = 0.40,
  fonte = 'fatiador, mesa cheia de 20 (3 placas)', atualizado_em = now()
  from public.produtos p where c.produto_id = p.id and p.slug = 'chaveiro-giratorio-cna';
update public.produto_custos c set gramas = 3.45, horas = 0.318, insumos = 0.40,
  fonte = 'fatiador, placa de 15', atualizado_em = now()
  from public.produtos p where c.produto_id = p.id and p.slug = 'chaveiro-monstrinho-cna';

commit;
