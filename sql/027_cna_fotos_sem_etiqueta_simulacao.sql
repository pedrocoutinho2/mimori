-- 027 · Fotos dos chaveiros CNA sem a etiqueta "Simulação" (12/10/2026)
-- Pedido do Pedro: "nos produtos do CNA, tira da foto que é simulação, não tem porque falar isso".
-- As 12 fotos *-sim.jpg foram refeitas sem o texto "Simulação" no canto (mesmo nome de arquivo, sobem com o push).
-- O sufixo muda para ?v=20261012d para o navegador buscar a versão nova. A frase da descrição que citava
-- "fotos marcadas como simulação" sai; fica só o aviso de pequena diferença de cor.
-- O tipo 'excecao' no banco continua (controle interno de foto a trocar pela peça real; não aparece no site).
-- Não apaga dado.
begin;
update public.produto_fotos set caminho = regexp_replace(caminho, '\?v=\w+$', '') || '?v=20261012d'
  where caminho like 'assets/fotos/chaveiro-%-sim.jpg%';
update public.produto_opcoes set foto = regexp_replace(foto, '\?v=\w+$', '') || '?v=20261012d'
  where foto like 'assets/fotos/chaveiro-%-sim.jpg%';
update public.produtos set descricao = replace(descricao,
  'As fotos marcadas como simulação mostram como fica cada monstrinho. A peça pronta pode ter pequena diferença de cor.',
  'A peça pronta pode ter pequena diferença de cor.')
  where slug in ('chaveiro-giratorio-cna', 'chaveiro-monstrinho-cna');
commit;
