-- 021 · Chaveiros CNA: fotos reais, vídeos, monstrinhos como opção e simulações (12/10/2026)
-- [APLICAR] depois do push do commit com o Ben (12/10/2026). A primeira tentativa via MCP foi cancelada; esta versão não apaga nada.
-- Fotos e vídeos em assets/fotos e assets/videos (sobem com o push). Fotos reais: IMG_2358 a 2363 de 12/10.
-- Simulações (tipo 'excecao', com a etiqueta "Simulação" na imagem): feitas sobre a foto real da Dani e do
-- giratório vermelho, com o desenho de cada monstrinho tirado do chaveiros-monstros-cna.3mf. Trocar pela
-- foto da peça real pelo painel conforme imprimir.
-- Correção: a descrição do giratório dizia disco branco com a Dani; a peça real tem moldura vermelha,
-- disco vermelho com o Ben de um lado e a logo CNA do outro.
-- Preço continua 0 (sob orçamento): as opções entram com preço 0 e o site não mostra valor.
begin;

-- monstrinhos como opção
insert into public.produto_opcoes (produto_id, nome, preco, ordem)
  select p.id, o.nome, 0, o.n - 1 from public.produtos p,
  unnest(array['Ben','Dani','Iza','Ju','Leo','Sol','Thiago']) with ordinality o(nome, n)
  where p.slug = 'chaveiro-giratorio-cna' and not exists (select 1 from public.produto_opcoes x where x.produto_id = p.id);
insert into public.produto_opcoes (produto_id, nome, preco, ordem)
  select p.id, o.nome, 0, o.n - 1 from public.produtos p,
  unnest(array['Dani','Iza','Ju','Leo','Sol','Thiago','Ben']) with ordinality o(nome, n)
  where p.slug = 'chaveiro-monstrinho-cna' and not exists (select 1 from public.produto_opcoes x where x.produto_id = p.id);

-- fotos: reais primeiro, depois as simulações
insert into public.produto_fotos (produto_id, caminho, tipo, ordem)
  select p.id, 'assets/fotos/' || f.arq, f.tipo, f.n - 1 from public.produtos p,
  (values ('chaveiro-giratorio-cna-1.jpg','real',1),('chaveiro-giratorio-cna-2.jpg','real',2),
          ('chaveiro-giratorio-dani-sim.jpg','excecao',3),('chaveiro-giratorio-iza-sim.jpg','excecao',4),('chaveiro-giratorio-ju-sim.jpg','excecao',5),
          ('chaveiro-giratorio-leo-sim.jpg','excecao',6),('chaveiro-giratorio-sol-sim.jpg','excecao',7),('chaveiro-giratorio-thiago-sim.jpg','excecao',8)) f(arq, tipo, n)
  where p.slug = 'chaveiro-giratorio-cna' and not exists (select 1 from public.produto_fotos x where x.produto_id = p.id);
insert into public.produto_fotos (produto_id, caminho, tipo, ordem)
  select p.id, 'assets/fotos/' || f.arq, f.tipo, f.n - 1 from public.produtos p,
  (values ('chaveiro-monstrinho-cna-1.jpg','real',1),('chaveiro-monstrinho-cna-2.jpg','real',2),
          ('chaveiro-monstrinho-iza-sim.jpg','excecao',3),('chaveiro-monstrinho-ju-sim.jpg','excecao',4),('chaveiro-monstrinho-leo-sim.jpg','excecao',5),
          ('chaveiro-monstrinho-sol-sim.jpg','excecao',6),('chaveiro-monstrinho-thiago-sim.jpg','excecao',7),('chaveiro-monstrinho-ben-sim.jpg','excecao',8)) f(arq, tipo, n)
  where p.slug = 'chaveiro-monstrinho-cna' and not exists (select 1 from public.produto_fotos x where x.produto_id = p.id);

-- vídeos
insert into public.produto_videos (produto_id, caminho, ordem)
  select p.id, 'assets/videos/chaveiro-giratorio-cna.mp4', 0 from public.produtos p where slug = 'chaveiro-giratorio-cna' and not exists (select 1 from public.produto_videos x where x.produto_id = p.id);
insert into public.produto_videos (produto_id, caminho, ordem)
  select p.id, 'assets/videos/chaveiro-monstrinho-cna.mp4', 0 from public.produtos p where slug = 'chaveiro-monstrinho-cna' and not exists (select 1 from public.produto_videos x where x.produto_id = p.id);

-- descrições
update public.produtos set atualizado_em = now(), descricao = $d$🌀 Um chaveiro com um disco que gira dentro da moldura vermelha. De um lado, o rostinho de um monstrinho do CNA. Do outro, a logo do CNA. É só girar pra trocar de lado.

Tem com todos os monstrinhos: Ben, Dani, Iza, Ju, Leo, Sol e Thiago. Um brinde pro aluno levar na mochila e mostrar pra turma toda.

📦 O QUE VEM NO PEDIDO
1 chaveiro giratório com o monstrinho escolhido e a logo do CNA
1 corrente com argola de chaveiro

📏 FICHA TÉCNICA
Material: PLA
Moldura vermelha com anel branco e disco giratório
Monstrinho em preto de um lado do disco e logo do CNA em preto do outro
As fotos marcadas como simulação mostram como fica cada monstrinho. A peça pronta pode ter pequena diferença de cor.

🏫 PARA A SUA UNIDADE
Brinde de matrícula, rematrícula, aniversário ou evento. Dá pra misturar os monstrinhos no mesmo pedido. O valor sai pela quantidade: chama a gente no WhatsApp com o número de alunos e a data.

⏱️ PRAZO
Pedido pequeno: de 3 a 5 dias úteis depois do pagamento.
Lote: o prazo a gente combina com você pela quantidade.

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.$d$
where slug = 'chaveiro-giratorio-cna';

update public.produtos set atualizado_em = now(), descricao = $d$💙 Um chaveiro no formato do rostinho de um monstrinho do CNA, com o desenho em preto na frente e a logo do CNA atrás. Leve e fininho, fica lindo na mochila, no estojo ou na chave de casa.

Tem com todos os monstrinhos, cada um na sua cor: Dani, Iza, Ju, Leo, Sol, Thiago e Ben.

📦 O QUE VEM NO PEDIDO
1 chaveiro com o monstrinho escolhido e a logo do CNA no verso
1 corrente com argola de chaveiro

📏 FICHA TÉCNICA
Material: PLA, em duas cores: a cor do monstrinho e o preto
Largura: aproximadamente 4,9 cm. A altura muda de um monstrinho pro outro, de 4 a 5 cm
Frente com o rostinho em preto, verso com a logo do CNA em preto
As fotos marcadas como simulação mostram como fica cada monstrinho. A peça pronta pode ter pequena diferença de cor.

🏫 PARA A SUA UNIDADE
Brinde de matrícula, rematrícula, aniversário ou evento. Dá pra misturar os monstrinhos no mesmo pedido. O valor sai pela quantidade: chama a gente no WhatsApp com o número de alunos e a data.

⏱️ PRAZO
Pedido pequeno: de 3 a 5 dias úteis depois do pagamento.
Lote: o prazo a gente combina com você pela quantidade.

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.$d$
where slug = 'chaveiro-monstrinho-cna';

commit;
