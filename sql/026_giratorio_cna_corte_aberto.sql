-- 026 · Fotos do Chaveiro Giratório CNA com corte mais aberto (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP, a pedido do Pedro ("zoom absurdo" na foto do produto).
-- As 7 fotos de frente (Ben e as 6 simulações) foram recortadas de novo a partir do original IMG_2370,
-- na largura inteira da foto, com o chaveiro e a corrente inteiros e a mão aparecendo. Mesmo nome de arquivo;
-- o sufixo muda de ?v=20261012b para ?v=20261012c para o navegador buscar a versão nova.
-- A foto do verso (cna-2) não mudou: não há original dela no vault.
-- Não apaga dado: só troca o sufixo dos caminhos.
update public.produto_fotos f set caminho = replace(f.caminho, '?v=20261012b', '?v=20261012c') from public.produtos p
  where f.produto_id = p.id and p.slug = 'chaveiro-giratorio-cna' and f.caminho not like '%giratorio-cna-2%';
update public.produto_opcoes o set foto = replace(o.foto, '?v=20261012b', '?v=20261012c') from public.produtos p
  where o.produto_id = p.id and p.slug = 'chaveiro-giratorio-cna';
