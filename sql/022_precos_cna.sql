-- 022 · Preços da página /cna (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 022_precos_cna), a pedido do Pedro ("você já tem os valores").
-- Só update e insert de custo; não apaga nada.
--
-- Regras usadas (decisões do Pedro):
--  * 1 unidade: regra do catálogo de 04/10 · (custo + embalagem R$ 2,50) × 2,5 quando o custo é abaixo de R$ 10, terminado em ,90
--  * Quantidade: decisão de 10/10 · markup de cerca de 1,5 sobre o custo da faixa, 50+ a consultar
--  * Microfone: R$ 29,90, decisão de 29/09/2026 (mantida; a regra de 04/10 daria R$ 21,90)
-- Custos de origem:
--  * Giratório: R$ 4,11 com argola, 3 placas, 1 por mesa (fatiador, conversa de 12/10) · 1 un R$ 16,90 · 10+ R$ 6,90
--    (sem fatiamento de mesa cheia; o custo da faixa é o de 1 por mesa)
--  * Monstrinho: R$ 2,69 com argola (1 peça) e R$ 1,21 (mesa de 20) · SUPOSIÇÃO, sem print do fatiador · 1 un R$ 13,90 · 10+ R$ 2,90 · 20+ R$ 1,90
--  * Plaquinhas: kit de 3 a R$ 2,29 pelo método do app (placa de 12 ÷ 4) · 1 kit R$ 12,90 · 10+ R$ 3,90 · canetinhas fora
begin;

update public.produtos set preco = 16.90, a_partir = false, faixas = '[{"min":10,"preco":6.9}]'::jsonb, faixa_consulta = 50, atualizado_em = now()
  where slug = 'chaveiro-giratorio-cna';
update public.produtos set preco = 13.90, a_partir = false, faixas = '[{"min":10,"preco":2.9},{"min":20,"preco":1.9}]'::jsonb, faixa_consulta = 50, atualizado_em = now()
  where slug = 'chaveiro-monstrinho-cna';
update public.produtos set preco = 29.90, a_partir = false, faixas = '[]'::jsonb, faixa_consulta = 50, atualizado_em = now()
  where slug = 'microfone-cna';
update public.produtos set preco = 12.90, a_partir = false, faixas = '[{"min":10,"preco":3.9}]'::jsonb, faixa_consulta = 50, atualizado_em = now(),
  descricao = replace(descricao, $o$📦 O QUE VEM NO PEDIDO
As plaquinhas dos monstrinhos que você escolher
Se quiser, a gente monta o kit com canetinhas$o$, $n$📦 O QUE VEM NO PEDIDO
1 kit com 3 plaquinhas dos monstrinhos que você escolher
As canetinhas não acompanham. Se quiser o kit com canetinhas, a gente combina no WhatsApp$n$)
  where slug = 'plaquinhas-de-pintar-monstrinhos-cna';

-- opções de monstrinho com o mesmo preço do produto
update public.produto_opcoes o set preco = p.preco from public.produtos p
  where o.produto_id = p.id and p.slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');

-- texto de preço nas descrições
update public.produtos set descricao = replace(descricao, 'O valor sai pela quantidade: chama a gente no WhatsApp com o número de alunos e a data.', 'A partir de 10 unidades o preço baixa, e acima de 50 a gente combina com você no WhatsApp.')
  where slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna');
update public.produtos set descricao = replace(descricao, 'O valor sai pela quantidade de alunos: chama a gente no WhatsApp.', 'A partir de 10 kits o preço baixa, e acima de 50 a gente combina com você no WhatsApp.')
  where slug = 'plaquinhas-de-pintar-monstrinhos-cna';
update public.produtos set descricao = replace(descricao, 'O valor sai pela quantidade: chama a gente no WhatsApp.', 'Acima de 50 unidades a gente combina o valor com você no WhatsApp.')
  where slug = 'microfone-cna';

-- custo no painel (fatiador), só onde ainda não existe
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
  select id, 19.11, 1.85, 0.40, 'fatiador' from public.produtos where slug = 'chaveiro-giratorio-cna' on conflict (produto_id) do nothing;
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
  select id, 11.9, 0.56, 0, 'fatiador' from public.produtos where slug = 'plaquinhas-de-pintar-monstrinhos-cna' on conflict (produto_id) do nothing;
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
  select id, 14, 0.75, 0.40, 'suposição' from public.produtos where slug = 'chaveiro-monstrinho-cna' on conflict (produto_id) do nothing;

commit;
