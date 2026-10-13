-- 030 · Preços dos chaveiros CNA, versão 3 (13/10/2026)
-- APLICADO em 13/10/2026 pelo Claude via MCP (migração 030_precos_chaveiros_cna_v3), decisão do Pedro na conversa.
-- Só update; não apaga nada. Substitui os preços do 028.
--
-- Custo por unidade em placa cheia, com mão de obra, chaveiro R$ 0,40 e embalagem R$ 0,20 por peça:
--  * Giratório R$ 4,22 · Monstrinho R$ 1,71
-- Markup: 1 a 9 = 2,5 · 10 a 49 = 2 · 50 a 99 = 1,8, arredondado para cima no ,90.
--  * Giratório:  R$ 10,90 / 8,90 / 7,90 · 100+ a consultar
--  * Monstrinho: R$ 4,90 / 3,90 / 2,90 · 100+ a consultar (50+ a R$ 2,90 por decisão do Pedro, markup efetivo 1,7)
-- Decisão: Second Brain/50-decisoes/2026-10-12-mimori-precos-chaveiros-cna.md (seção de 13/10)
begin;

update public.produtos set preco = 10.90, a_partir = false,
  faixas = '[{"min":10,"preco":8.9},{"min":50,"preco":7.9}]'::jsonb, faixa_consulta = 100, atualizado_em = now()
  where slug = 'chaveiro-giratorio-cna';
update public.produtos set preco = 4.90, a_partir = false,
  faixas = '[{"min":10,"preco":3.9},{"min":50,"preco":2.9}]'::jsonb, faixa_consulta = 100, atualizado_em = now()
  where slug = 'chaveiro-monstrinho-cna';

update public.produto_opcoes o set preco = p.preco from public.produtos p
  where o.produto_id = p.id and p.slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');

-- insumos por peça: chaveiro R$ 0,40 + embalagem R$ 0,20
update public.produto_custos c set insumos = 0.60, atualizado_em = now()
  from public.produtos p where c.produto_id = p.id and p.slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');

commit;
