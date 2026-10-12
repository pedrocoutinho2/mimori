-- 020 · Página /cna: categoria oculta Brindes CNA e 4 produtos (12/10/2026)
-- APLICADO em 12/10/2026 às 17h30 pelo Claude via MCP (migração 020_pagina_cna), depois do push do commit "cna".
-- Regra: aplicar só DEPOIS do push do index.html e do gerar-paginas.py desta data. Aplicado antes, o site que está
-- no ar mostra "Brindes CNA" no menu e preço R$ 0,00, porque o código antigo não conhece oculta nem sob orçamento.
-- Depende do 019 (coluna categorias.oculta).
--
-- Preço 0 = sob orçamento: o site mostra "Sob orçamento" e a mensagem do WhatsApp pede o valor.
-- Fotos: nenhuma no banco. Subir a foto da peça real pelo painel. Do microfone já existe
-- 18-mimori/produtos/microfone/fotos/00-original-cna.jpg no vault.
-- Sem tags de propósito: promoção por tag não alcança estes produtos.
begin;

insert into public.categorias (slug, nome, ordem, oculta) values ('cna', 'Brindes CNA', 90, true)
  on conflict (slug) do update set oculta = true;

create temp table _c on commit drop as select * from jsonb_to_recordset($j$[
{"sku":"MIM-CNGI01","slug":"chaveiro-giratorio-cna","nome":"Chaveiro Giratório CNA","selo":"Gira dos dois lados","ordem":901,
 "descricao":"🌀 Um chaveiro com um disco que gira dentro da moldura. De um lado, a logo do CNA. Do outro, a Dani, a monstrinha azul. É só girar pra trocar de lado.\n\nUm brinde pro aluno levar na mochila e mostrar pra turma toda.\n\n📦 O QUE VEM NO PEDIDO\n1 chaveiro giratório com a logo do CNA e a Dani\n1 corrente com argola de chaveiro\n\n📏 FICHA TÉCNICA\nMaterial: PLA\nTamanho: 70,6 x 80,5 x 8 mm\nDisco branco com a logo do CNA em vermelho e a Dani colorida\nCor da moldura: a gente combina com você\n\n🏫 PARA A SUA UNIDADE\nBrinde de matrícula, rematrícula, aniversário ou evento. O valor sai pela quantidade: chama a gente no WhatsApp com o número de alunos e a data.\n\n⏱️ PRAZO\nPedido pequeno: de 3 a 5 dias úteis depois do pagamento.\nLote: o prazo a gente combina com você pela quantidade.\n\n🧼 CUIDADOS\nLimpar com pano seco.\nNão deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.\nNão é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas."},
{"sku":"MIM-CNMO01","slug":"chaveiro-monstrinho-cna","nome":"Chaveiro Monstrinho CNA","selo":"Logo no verso","ordem":902,
 "descricao":"💙 Um chaveiro no formato de um monstrinho do CNA, com o rostinho colorido na frente e a logo do CNA atrás. Leve e pequeno, fica lindo na mochila, no estojo ou na chave de casa.\n\n📦 O QUE VEM NO PEDIDO\n1 chaveiro monstrinho com a logo do CNA no verso\n1 corrente com argola de chaveiro\n\n📏 FICHA TÉCNICA\nMaterial: PLA\nFrente com o rosto do monstrinho embutido em outra cor\nVerso com a logo do CNA\nMonstrinho e cores: a gente combina com você\n\n🏫 PARA A SUA UNIDADE\nBrinde de matrícula, rematrícula, aniversário ou evento. O valor sai pela quantidade: chama a gente no WhatsApp com o número de alunos e a data.\n\n⏱️ PRAZO\nPedido pequeno: de 3 a 5 dias úteis depois do pagamento.\nLote: o prazo a gente combina com você pela quantidade.\n\n🧼 CUIDADOS\nLimpar com pano seco.\nNão deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.\nNão é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas."},
{"sku":"MIM-CNMI01","slug":"microfone-cna","nome":"Microfone CNA","selo":"Canopla CNA","ordem":903,
 "descricao":"🎤 Um mini microfone de repórter com a canopla vermelha e o CNA em preto. Pra gravar vídeo com aluno, entrevista em evento, apresentação de turma e conteúdo da unidade.\n\nEle é cenográfico: não grava som. O que ele faz é deixar o vídeo com cara de reportagem. 😉\n\n📦 O QUE VEM NO PEDIDO\n1 mini microfone com a canopla CNA\n\n📏 FICHA TÉCNICA\nMaterial: PLA\nCanopla vermelha com o CNA em relevo preto\nCabeça preta com textura de espuma\nCabo preto\n\n🏫 PARA A SUA UNIDADE\nPra equipe usar nos vídeos da unidade ou pra presentear em evento. O valor sai pela quantidade: chama a gente no WhatsApp.\n\n⏱️ PRAZO\nPedido pequeno: de 3 a 5 dias úteis depois do pagamento.\nLote: o prazo a gente combina com você pela quantidade.\n\n🧼 CUIDADOS\nLimpar com pano seco.\nNão deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.\nNão é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas."},
{"sku":"MIM-CNPP01","slug":"plaquinhas-de-pintar-monstrinhos-cna","nome":"Plaquinhas de Pintar Monstrinhos CNA","selo":"Pra colorir","ordem":904,
 "descricao":"🎨 Plaquinhas com os monstrinhos do CNA, com o contorno preto em relevo sobre a base branca, prontas pra pintar. A criança colore cada pedacinho e leva pra casa um monstrinho do jeito dela.\n\nO contorno em relevo ajuda a pintar sem sair da linha.\n\n📦 O QUE VEM NO PEDIDO\nAs plaquinhas dos monstrinhos que você escolher\nSe quiser, a gente monta o kit com canetinhas\n\n📏 FICHA TÉCNICA\nMaterial: PLA\nBase branca com contorno preto em relevo\nMonstrinhos: Ben e a turma de monstrinhos do CNA, a gente confirma quais com você\n\n🏫 PARA A SUA UNIDADE\nAtividade pro Dia das Crianças, aula especial, colônia de férias ou evento com as famílias. O valor sai pela quantidade de alunos: chama a gente no WhatsApp.\n\n⏱️ PRAZO\nPedido pequeno: de 3 a 5 dias úteis depois do pagamento.\nLote: o prazo a gente combina com você pela quantidade.\n\n🧼 CUIDADOS\nLimpar com pano seco.\nNão deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.\nPintura com acompanhamento de um adulto. Não indicado para menores de 3 anos."}
]$j$::jsonb) as x(sku text, slug text, nome text, selo text, ordem int, descricao text);

insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos)
  select x.slug, x.sku, x.nome, c.id, 0, x.descricao, true, x.ordem, '{}'::text[], x.selo, false, '{}'::text[]
  from _c x cross join public.categorias c where c.slug = 'cna'
  on conflict (slug) do nothing;

-- custo do microfone: fatiador de 29/09/2026 (2 placas, 35,54 g, 2h20, camada 0,20 mm SUPOSIÇÃO)
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
  select p.id, 35.54, 2.33, 0, 'fatiador' from public.produtos p where p.slug = 'microfone-cna'
  on conflict (produto_id) do nothing;

commit;

-- conferência
select p.sku, p.nome, p.preco, p.publicado, c.slug as categoria, c.oculta
from public.produtos p join public.categorias c on c.id = p.categoria_id
where c.slug = 'cna' order by p.ordem;
