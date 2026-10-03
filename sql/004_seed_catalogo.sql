-- 004_seed_catalogo.sql
-- ALTERNATIVA ao botão "Importar o catálogo" do painel. Não rode se já importou pelo painel: duplica fotos e cores.
-- Colunas que o site usa e a carga inicial dos 68 produtos do catálogo (gerado de data/catalogo.json em 02/10/2026).
-- Rodar depois do 001, 002 e 003. As fotos iniciais ficam no próprio repositório (assets/fotos); as novas sobem pelo painel para o Storage.

alter table public.produtos add column if not exists selo text;
alter table public.produtos add column if not exists a_partir boolean not null default false;
alter table public.produtos add column if not exists grupos text[] not null default '{}';

insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'nossa-senhora-do-manto', 'MIM-NSRA01', 'Nossa Senhora do Manto', c.id, 27.9, '🙏 Nossa Senhora em traço moderno, com véu azul acetinado e auréola dourada. Fica bonita no quarto, na sala, no oratório ou na mesa de trabalho, e é um presente com significado para mãe, avó ou madrinha.

Tem em duas versões: imagem azul claro ou imagem preta. O véu azul e o terço dourado em relevo são iguais nas duas.

📦 O QUE VEM NO PEDIDO
1 imagem de Nossa Senhora na versão escolhida

📏 FICHA TÉCNICA
Material: PLA com acabamento acetinado
Altura: aproximadamente 8 cm
Peso: aproximadamente 15 g
Cores: véu azul, auréola e terço dourados, imagem azul claro ou imagem preta

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Serve para presente de batizado ou primeira comunhão? Sim, e para quantidades maiores chame a gente no WhatsApp.
A cor é igual à da foto? O filamento acetinado muda um pouco com a luz do ambiente.', true, 1, array['Aniversário','Avó','Batizado e comunhão','Dia das Mães','Mãe','Natal','Quem tem fé']::text[], null, false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/nossa-senhora-do-manto-1.jpg', 'excecao', 0 from public.produtos where slug = 'nossa-senhora-do-manto';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/nossa-senhora-do-manto-2.jpg', 'excecao', 1 from public.produtos where slug = 'nossa-senhora-do-manto';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'nossa-senhora-do-manto';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 1 from public.produtos where slug = 'nossa-senhora-do-manto';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 25, 1.2, 'suposição' from public.produtos where slug = 'nossa-senhora-do-manto' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'porta-terco-bandeja-ore-e-confie', 'MIM-BAND01', 'Porta Terço Bandeja Ore e Confie', c.id, 47.9, '🙏 Nossa Senhora ajoelhada em oração, ao lado de uma bandeja com a frase Ore e confie em relevo. Guarda o terço à vista na cabeceira, na escrivaninha ou no oratório, e ainda serve para anéis, chaves e pequenos objetos.

Você monta a sua: escolha uma cor para a santa e outra para a bandeja, entre Branco, Bege, Rosa bebê, Marrom, Azul bebê e Cinza claro. Também pode pedir as duas na mesma cor.

📦 O QUE VEM NO PEDIDO
1 bandeja com a imagem de Nossa Senhora, nas cores escolhidas
O terço das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Cores para a santa e para a bandeja: Branco, Bege, Rosa bebê, Marrom, Azul bebê e Cinza claro

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso escolher cores diferentes para a santa e para a bandeja? Sim, é só selecionar a cor de cada uma na hora da compra.
O terço vem junto? Não, a bandeja é vendida sem o terço.
Serve para presente de batizado, crisma ou Dia das Mães? Sim, e para quantidades maiores chame a gente no WhatsApp.
A cor é igual à da foto? As fotos de combinação são uma simulação das cores, e o filamento muda um pouco com a luz do ambiente.', true, 2, array['Aniversário','Avó','Batizado e comunhão','Dia das Mães','Monte a sua','Mãe','Natal','Quem tem fé']::text[], 'Monte a sua', false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-bandeja-ore-e-confie-1.jpg', 'excecao', 0 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-bandeja-ore-e-confie-2.jpg', 'excecao', 1 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-bandeja-ore-e-confie-3.jpg', 'excecao', 2 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 2 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 4 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Cinza claro', 5 from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 110, 6, 'suposição' from public.produtos where slug = 'porta-terco-bandeja-ore-e-confie' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'kit-ore-e-confie-com-bandeja-e-porta-vela', 'MIM-KORE01', 'Kit Ore e Confie com Bandeja e Porta Vela', c.id, 41.9, '🙏 Um cantinho de fé pronto para a sua mesa. A bandeja oval canelada recebe o letreiro Ore e Confie e o porta vela com coração, e o conjunto vira um pequeno oratório na cabeceira, na escrivaninha, na estante ou no aparador da sala.

Cada peça também funciona sozinha: a bandeja guarda terço, anéis, chaves e pequenos objetos.

📦 O QUE VEM NO PEDIDO
1 bandeja oval canelada
1 letreiro Ore e Confie
1 porta vela com coração
A vela de LED das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Cores: bandeja e porta vela em marrom acinzentado, letreiro em bege com a frase em cinza, como nas fotos
Bandeja: 19,7 cm de comprimento, 12,3 cm de largura e 1,6 cm de altura
Peso das peças impressas: aproximadamente 145 g

🧼 CUIDADOS
Use só vela de LED. O PLA não resiste à chama de vela comum e pode deformar ou pegar fogo.
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso usar vela de verdade? Não. Use só vela de LED, como a das fotos.
A vela vem junto? Não, o kit vem com as três peças impressas.
Serve para presente? Sim, para mãe, avó, madrinha, batizado ou crisma. Para quantidades maiores, chame a gente no WhatsApp.
A cor é igual à da foto? As fotos são da peça real, e o filamento muda um pouco com a luz do ambiente.', true, 3, array['Avó','Casa nova','Dia das Mães','Kit','Mãe','Natal','Quem tem fé']::text[], 'Kit', false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/kit-ore-e-confie-com-bandeja-e-porta-vela-1.jpg', 'real', 0 from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/kit-ore-e-confie-com-bandeja-e-porta-vela-2.jpg', 'real', 1 from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/kit-ore-e-confie-com-bandeja-e-porta-vela-3.jpg', 'real', 2 from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/kit-ore-e-confie-com-bandeja-e-porta-vela-4.jpg', 'real', 3 from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela';
insert into public.produto_videos (produto_id, caminho, ordem) select id, 'assets/videos/kit-ore-e-confie-com-bandeja-e-porta-vela.mp4', 0 from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 146.64, 5.79, 'fatiador' from public.produtos where slug = 'kit-ore-e-confie-com-bandeja-e-porta-vela' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'letreiro-ore-e-confie', 'MIM-OREC01', 'Letreiro Ore e Confie', c.id, 34.9, '🙏 Duas palavras que cabem na mesa e no dia inteiro. O letreiro Ore e Confie fica de pé sozinho na escrivaninha, na estante, na cabeceira ou no cantinho de oração.

Você escolhe a combinação: a base ORE em Branco, Bege, Marrom ou Verde oliva, e a frase e confie em Preto ou Branco.

📦 O QUE VEM NO PEDIDO
1 letreiro Ore e Confie, nas cores escolhidas
Vaso e planta das fotos não acompanham o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 11,7 cm de largura, 5,6 cm de altura e 2,5 cm de profundidade
Peso: aproximadamente 43 g
Cores da base: Branco, Bege, Marrom ou Verde oliva
Cores da frase: Preto ou Branco

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
A cor é igual à da foto? As fotos de combinação são uma simulação das cores, e o filamento muda um pouco com a luz do ambiente.
Serve para presente? Sim, e para quantidades maiores é só chamar no chat.', true, 4, array['Amiga ou amigo','Amigo secreto','Casa nova','Colega de trabalho','Natal','Quem tem fé']::text[], null, false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/letreiro-ore-e-confie-1.jpg', 'real', 0 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/letreiro-ore-e-confie-2.jpg', 'real', 1 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.produto_videos (produto_id, caminho, ordem) select id, 'assets/videos/letreiro-ore-e-confie.mp4', 0 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 2 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 3 from public.produtos where slug = 'letreiro-ore-e-confie';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 61.86, 2.87, 'fatiador' from public.produtos where slug = 'letreiro-ore-e-confie' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'porta-terco-nossa-senhora-oratorio', 'MIM-ORAT01', 'Porta Terço Nossa Senhora Oratório', c.id, 31.9, '🤍 Nossa Senhora com coroa e manto que se abre numa bandeja, feita para guardar o terço sempre à vista. Fica na cabeceira, na escrivaninha ou no oratório, e é um presente de fé para mãe, avó ou madrinha.

O manto em linhas simples deixa a peça moderna e combina com qualquer decoração.

📦 O QUE VEM NO PEDIDO
1 porta terço Nossa Senhora
O terço das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Cor: branco

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
O terço vem junto? Não, a peça é vendida sem o terço.
Serve para batizado, crisma ou primeira comunhão? Sim, e para quantidades maiores chame a gente no WhatsApp.', true, 5, array['Aniversário','Avó','Batizado e comunhão','Dia das Mães','Quem tem fé']::text[], null, false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-nossa-senhora-oratorio-1.jpg', 'excecao', 0 from public.produtos where slug = 'porta-terco-nossa-senhora-oratorio';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-nossa-senhora-oratorio-2.jpg', 'excecao', 1 from public.produtos where slug = 'porta-terco-nossa-senhora-oratorio';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-terco-nossa-senhora-oratorio-3.jpg', 'excecao', 2 from public.produtos where slug = 'porta-terco-nossa-senhora-oratorio';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'porta-terco-nossa-senhora-oratorio';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'mini-jesus-sentado', 'MIM-JESU01', 'Mini Jesus Sentado', c.id, 17.9, '🙏 Um Jesus pequenininho, de 3,5 cm, sentado na borda do monitor, fazendo companhia no trabalho e nos estudos. Também fica na estante, no nicho ou na mesa de cabeceira.

As cores saem direto do filamento: cabelo e barba castanhos, túnica branca e sandálias marrons. Tem em kits de 1, 2, 3 ou 4 unidades.

📦 O QUE VEM NO PEDIDO
Mini Jesus Sentado na quantidade escolhida: 1 unidade, 2 unidades, 3 unidades ou 4 unidades

📏 FICHA TÉCNICA
Material: PLA
Altura: aproximadamente 3,5 cm. É uma peça mini, confira a medida antes de comprar.
Peso: aproximadamente 3 g por unidade
Cores: túnica branca, cabelo e barba castanhos, sandálias marrons

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem partes pequenas.

💬 PERGUNTAS FREQUENTES
Fica em notebook também? Sim, apoiado na borda de cima da tela.
Precisa de mais de 4? Chame a gente no WhatsApp.', true, 6, array['Amiga ou amigo','Amigo secreto','Batizado e comunhão','Colega de trabalho','Kit','Lembrança de festa','Natal','Quem tem fé','Sai em lote']::text[], 'Kits de 1 a 4', true, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/mini-jesus-sentado-1.jpg', 'excecao', 0 from public.produtos where slug = 'mini-jesus-sentado';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 23, 0.6, 'suposição' from public.produtos where slug = 'mini-jesus-sentado' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'luminaria-jesus-escada-para-o-ceu', 'MIM-LUJE01', 'Luminária Jesus Escada para o Céu', c.id, 119.9, '✨ Jesus de braços abertos subindo uma escada em espiral, com a base acesa em luz quente. Fica linda no quarto, na sala ou no cantinho de oração, e é um presente de fé para quem você ama.

A luz sai da base e atravessa o manto, criando um brilho suave que funciona como luz noturna.

📦 O QUE VEM NO PEDIDO
1 luminária Jesus com escada espiral
1 base com luz LED
1 cabo USB para ligar a luz

📏 FICHA TÉCNICA
Material: PLA
Altura: aproximadamente 15 cm
Diâmetro da base: aproximadamente 10 cm
Peso: aproximadamente 60 g, sem o cabo
Cores: figura e escada em branco, base preta
Luz: LED branco quente, ligado por cabo USB (fonte de celular ou computador)

🧼 CUIDADOS
Limpar com pano seco, com a luz desligada.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
A escada é delicada: segure a peça pela base.

💬 PERGUNTAS FREQUENTES
A luz esquenta a peça? Não. O LED quase não gera calor.
Serve de luz noturna? Sim, a luz é suave e quente.
Precisa de tomada? Liga em qualquer entrada USB: carregador de celular, computador ou TV. O carregador não acompanha.
Dá para presentear? Sim, vai protegida em caixa.', true, 7, array['Aniversário','Avó','Com luz','Dia das Mães','Mãe','Natal','Quem tem fé']::text[], 'Com luz LED', false, '{}'::text[] from public.categorias c where c.slug = 'produtos-religiosos' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/luminaria-jesus-escada-para-o-ceu-1.jpg', 'excecao', 0 from public.produtos where slug = 'luminaria-jesus-escada-para-o-ceu';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/luminaria-jesus-escada-para-o-ceu-2.jpg', 'excecao', 1 from public.produtos where slug = 'luminaria-jesus-escada-para-o-ceu';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/luminaria-jesus-escada-para-o-ceu-3.jpg', 'excecao', 2 from public.produtos where slug = 'luminaria-jesus-escada-para-o-ceu';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 90.14, 4.5, 'suposição' from public.produtos where slug = 'luminaria-jesus-escada-para-o-ceu' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-sapo', null, 'Vaso Sapo', c.id, 106.9, '', false, 8, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-carinha-feliz', 'MIM-FELI01', 'Vaso Carinha Feliz', c.id, 53.9, '😊 Um vaso grande de sorriso largo, para plantas de verdade. Alegra a sala logo na entrada.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso carinha feliz
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 12 × 12 × 11 cm
Peso: aproximadamente 210 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Muda em pote de até 11 cm.
Tem furo embaixo?
Não. Use como cachepô.', true, 9, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-carinha-feliz';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-carinha-feliz';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-carinha-feliz';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-dedal', null, 'Vaso Dedal', c.id, 55.9, '', false, 10, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-coruja', 'MIM-CORU01', 'Vaso Coruja', c.id, 25.9, '🦉 Uma corujinha de olhos grandes guardando a sua suculenta. Pequena, cabe em qualquer canto.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso coruja
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: pequeno (cerca de 6 × 6 × 7 cm)
Peso: aproximadamente 37 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto de muda.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 11, array['Aniversário','Bichinho e personagem','Casa nova','Halloween','Quem ama plantas','Sai em lote']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coruja-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-coruja';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coruja-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-coruja';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coruja-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-coruja';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 37.0, 1.42, 'suposição' from public.produtos where slug = 'vaso-coruja' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-ninho-bicolor', 'MIM-NINH01', 'Vaso Ninho Bicolor', c.id, 59.9, '🪺 Uma casca externa e um miolo encaixado em outra cor, como um ninho. O contraste dá acabamento de peça cara.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 base externa
1 miolo encaixado
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 12 cm (altura SUPOSIÇÃO 10 cm)
Peso: aproximadamente 131 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso escolher a cor do miolo?
Nesta versão o miolo vem em Branco . Chame a gente no WhatsApp para outra combinação.
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.', true, 12, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], 'Duas cores', false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ninho-bicolor-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ninho-bicolor-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ninho-bicolor-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-ninho-bicolor';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 131.0, 3.71, 'suposição' from public.produtos where slug = 'vaso-ninho-bicolor' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-inflado', 'MIM-INFL01', 'Vaso Inflado', c.id, 58.9, '☁️ Parece um tecido cheio de ar, mas é firme. O vaso inflado é a tendência de decoração que deixa a estante mais divertida.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso inflado
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10 cm (altura SUPOSIÇÃO 9 cm)
Peso: aproximadamente 122 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
É macio?
Não. É rígido, impresso em PLA. Só a aparência é de tecido.
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.', true, 13, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-inflado-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-inflado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-inflado-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-inflado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-inflado-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-inflado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-inflado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-inflado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-inflado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-inflado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-inflado';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 122.0, 5.01, 'suposição' from public.produtos where slug = 'vaso-inflado' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-moderno-drift-com-prato', 'MIM-DRIF01', 'Vaso Moderno Drift com Prato', c.id, 52.9, '🌿 O vaso tem textura de ondas e fica elevado dentro do prato, que abraça a base. A água escorre, o móvel fica seco e a peça parece escultura.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso com furo de drenagem
1 prato envolvente
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10,5 × 10,5 × 8 cm
Peso: aproximadamente 100 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso escolher uma cor para o vaso e outra para o prato?
Por enquanto vai na mesma cor. Chame a gente no WhatsApp para combinar duas cores.
Cabe que planta?
Suculentas, peperômia, jiboia e mudas pequenas.', true, 14, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-moderno-drift-com-prato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-moderno-drift-com-prato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-moderno-drift-com-prato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-moderno-drift-com-prato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 100.0, 5.42, 'suposição' from public.produtos where slug = 'vaso-moderno-drift-com-prato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-poligonal-com-prato', 'MIM-POLI01', 'Vaso Poligonal com Prato', c.id, 73.9, '🌿 Facetas geométricas que pegam luz de um jeito diferente em cada hora do dia. O vaso fica levemente suspenso sobre o prato, e a água que escorre não marca o móvel.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso poligonal
1 prato que abraça a base do vaso
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 11 × 11 × 10 cm
Peso: aproximadamente 156 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Tem. A água escorre para o prato, que fica encaixado sob o vaso.
Cabe que planta?
Suculentas, cactos, jiboia pequena, peperômia e mudas em vaso de até 9 cm.', true, 15, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-poligonal-com-prato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-poligonal-com-prato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-poligonal-com-prato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-poligonal-com-prato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 156.0, 7.4, 'suposição' from public.produtos where slug = 'vaso-poligonal-com-prato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-gato-sentado', 'MIM-GATS01', 'Vaso Gato Sentado', c.id, 62.9, '🐈 Um gato sentado, de rabo enrolado, segurando a planta no lugar da cabeça. Tamanho bom para jiboia pequena, peperômia e suculentas.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso gato sentado
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: vaso de 10 cm (cerca de 11 × 10 × 11 cm)
Peso: aproximadamente 132 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Qual o tamanho da boca?
Cerca de 10 cm no vaso, SUPOSIÇÃO. Serve para muda em pote 8.
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.', true, 16, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-sentado-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-gato-sentado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-sentado-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-gato-sentado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-sentado-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-gato-sentado';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 132.0, 5.34, 'suposição' from public.produtos where slug = 'vaso-gato-sentado' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-gatinho-fofo', 'MIM-GATF01', 'Vaso Gatinho Fofo', c.id, 38.9, '🐱 Um gatinho de orelhas em pé, com a planta no meio. Pequeno, cabe na escrivaninha e na janela.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso gatinho
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: vaso de 6 cm (cerca de 8 × 8 × 9 cm)
Peso: aproximadamente 70 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto pequeno. A boca tem cerca de 6 cm.
A segunda cor muda?
O detalhe segue a cor padrão da foto .', true, 17, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gatinho-fofo-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-gatinho-fofo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gatinho-fofo-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-gatinho-fofo';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 70.0, 2.81, 'suposição' from public.produtos where slug = 'vaso-gatinho-fofo' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-gato-mini', 'MIM-GATM01', 'Vaso Gato Mini', c.id, 37.9, '🐈 Um gatinho de linhas lisas, sem enfeite, com uma suculenta no lugar certo. Discreto e fofo na medida.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso gato mini
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 5,5 cm de boca (cerca de 6 × 6 × 7 cm)
Peso: aproximadamente 70 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Qual o tamanho?
Boca de 5,5 cm.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 18, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-mini-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-gato-mini';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-mini-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-gato-mini';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-mini-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-gato-mini';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 70.0, 2.1, 'suposição' from public.produtos where slug = 'vaso-gato-mini' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'gato-derrubando-vaso', 'MIM-GATD01', 'Gato Derrubando Vaso', c.id, 15.9, '😼 Todo dono de gato já viu essa cena. Agora ela fica parada na estante, sem nenhum vaso quebrado.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 miniatura gato com vaso
Peça decorativa

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: miniatura (cerca de 5 × 4 × 5 cm)
Peso: aproximadamente 11 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Uso: enfeite, sem espaço para planta

🧼 CUIDADOS
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
É vaso de verdade?
Não. É enfeite em miniatura, sem espaço para planta.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 19, array['Aniversário','Bichinho e personagem','Casa nova','Halloween','Quem ama plantas','Sai em lote']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/gato-derrubando-vaso-1.jpg', 'criador', 0 from public.produtos where slug = 'gato-derrubando-vaso';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/gato-derrubando-vaso-2.jpg', 'criador', 1 from public.produtos where slug = 'gato-derrubando-vaso';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/gato-derrubando-vaso-3.jpg', 'criador', 2 from public.produtos where slug = 'gato-derrubando-vaso';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 11.0, 0.58, 'suposição' from public.produtos where slug = 'gato-derrubando-vaso' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-gato', 'MIM-GATO01', 'Vaso Gato', c.id, 46.9, '🐈 Um gatinho de traço limpo e carinha tranquila, com a planta nas costas. Presente certo para quem tem gato em casa ou no coração.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso gato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10 cm de comprimento (demais SUPOSIÇÃO 7 × 8 cm)
Peso: aproximadamente 95 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto pequeno. A boca tem cerca de 5 cm, SUPOSIÇÃO.
Tem furo embaixo?
Não. Use como cachepô ou com pouca rega.', true, 20, array['Aniversário','Bichinho e personagem','Casa nova','Halloween','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-gato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-gato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-gato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-gato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-gato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-gato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-gato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-gato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 95.0, 2.9, 'suposição' from public.produtos where slug = 'vaso-gato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-dino', 'MIM-DINO01', 'Vaso Dino', c.id, 50.9, '🦕 Um dinossauro simpático carregando a planta nas costas. Deixa a estante mais divertida e vira assunto de toda visita.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso dinossauro em três cores
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 13 × 7 × 9 cm
Peso: aproximadamente 107 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso escolher as cores?
A cor escolhida vale para o corpo. Olhos e folha seguem o padrão da foto .
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.', true, 21, array['Aniversário','Bichinho e personagem','Casa nova','Criança','Dia das Crianças','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dino-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-dino';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dino-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-dino';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dino-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-dino';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 107.0, 3.12, 'suposição' from public.produtos where slug = 'vaso-dino' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-dragao-dormindo', 'MIM-DRAG01', 'Vaso Dragão Dormindo', c.id, 57.9, '🐉 Um dragão enrolado dormindo em volta do vaso, como se guardasse um tesouro verde. Para a estante de quem gosta de fantasia.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso dragão dormindo
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: cerca de 17,5 cm (70% do original de 25 cm)
Peso: aproximadamente 123 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Qual o tamanho?
Cerca de 17,5 cm.
Cabe que planta?
Suculentas e mudas pequenas.', true, 22, array['Aniversário','Bichinho e personagem','Casa nova','Halloween','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dragao-dormindo-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-dragao-dormindo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dragao-dormindo-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-dragao-dormindo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-dragao-dormindo-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-dragao-dormindo';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 123.0, 4.12, 'suposição' from public.produtos where slug = 'vaso-dragao-dormindo' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-elefante', 'MIM-ELEF01', 'Vaso Elefante', c.id, 55.9, '🐘 Um elefante facetado, de tromba erguida, levando a planta nas costas. Combina com sala, quarto e escritório.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso elefante
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: médio (cerca de 11 × 8 × 9 cm)
Peso: aproximadamente 120 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculentas e mudas em pote de até 7 cm.
Tem furo embaixo?
Não. Use como cachepô.', true, 23, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-elefante-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-elefante';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-elefante-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-elefante';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-elefante-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-elefante';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 120.0, 3.8, 'suposição' from public.produtos where slug = 'vaso-elefante' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-ourico', 'MIM-OURI01', 'Vaso Ouriço', c.id, 42.9, '🦔 Um ouriço gordinho que usa cacto e suculenta como espinhos. Fica ótimo com planta bem redondinha.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso ouriço
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 10 × 8 × 7 cm
Peso: aproximadamente 80 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Que planta combina?
Cacto bola, echeveria e mini suculentas.
Tem furo embaixo?
Não. Use como cachepô.', true, 24, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ourico-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-ourico';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ourico-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-ourico';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-ourico-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-ourico';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 80.0, 3.62, 'suposição' from public.produtos where slug = 'vaso-ourico' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-cachorro-salsicha', 'MIM-SALS01', 'Vaso Cachorro Salsicha', c.id, 33.9, '🐶 Um salsicha comprido que vira canteiro de suculentas. Dá para montar um mini jardim ao longo das costas dele.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso cachorro salsicha
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 18 cm de comprimento (cerca de 18 × 6 × 6 cm)
Peso: aproximadamente 56 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabem quantas suculentas?
Duas ou três mudas pequenas.
Serve de presente?
Para quem tem ou ama salsicha.', true, 25, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-cachorro-salsicha-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-cachorro-salsicha';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-cachorro-salsicha-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-cachorro-salsicha';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 56.0, 2.48, 'suposição' from public.produtos where slug = 'vaso-cachorro-salsicha' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-vaquinha-peluda', 'MIM-VACA01', 'Vaso Vaquinha Peluda', c.id, 28.9, '🐮 A vaquinha peluda de franja nos olhos, com uma suculenta na cabeça. Impossível não sorrir.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso vaquinha
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 7 × 7 × 7 cm
Peso: aproximadamente 42 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto de muda.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 26, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas','Sai em lote']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-vaquinha-peluda-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-vaquinha-peluda';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-vaquinha-peluda-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-vaquinha-peluda';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-vaquinha-peluda-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-vaquinha-peluda';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 42.0, 2.19, 'suposição' from public.produtos where slug = 'vaso-vaquinha-peluda' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-zuki-paz-e-amor', 'MIM-ZUKI01', 'Vaso Zuki Paz e Amor', c.id, 35.9, '✌️ Um bonequinho kawaii fazendo sinal de paz, com a suculenta de chapéu. Fofura na mesa de estudo.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso Zuki
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 8 × 8 × 8 cm
Peso: aproximadamente 63 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto de muda.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 27, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-zuki-paz-e-amor-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-zuki-paz-e-amor';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-zuki-paz-e-amor-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-zuki-paz-e-amor';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-zuki-paz-e-amor-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-zuki-paz-e-amor';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 63.0, 2.25, 'suposição' from public.produtos where slug = 'vaso-zuki-paz-e-amor' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-no-balanco', 'MIM-BALA01', 'Vaso no Balanço', c.id, 56.9, '🌱 Um vasinho feliz sentado num balanço, pronto para pendurar na janela. A planta cai pelos lados e o balanço faz o resto.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso com balanço
Cordão para pendurar:
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 10 × 8 × 14 cm
Peso: aproximadamente 112 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Como pendura?
Pelo cordão preso no balanço .
Aguenta planta com terra?
Muda pequena, sim.', true, 28, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-no-balanco-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-no-balanco';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-no-balanco-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-no-balanco';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-no-balanco-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-no-balanco';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 112.0, 5.82, 'suposição' from public.produtos where slug = 'vaso-no-balanco' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-leitora-aconchego', 'MIM-LEIT01', 'Vaso Leitora Aconchego', c.id, 32.9, '📚 Uma leitora encolhida com o livro, e a planta brotando do lado. Feito para a estante de quem não vive sem uma história.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso leitora
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 8 × 6 × 8 cm
Peso: aproximadamente 57 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta pequena ou planta aérea.
Serve de presente?
É o presente certo para quem ama livros.', true, 29, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-leitora-aconchego-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-leitora-aconchego';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-leitora-aconchego-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-leitora-aconchego';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-leitora-aconchego-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-leitora-aconchego';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 57.0, 2.08, 'suposição' from public.produtos where slug = 'vaso-leitora-aconchego' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-menina-lendo', 'MIM-LEND01', 'Vaso Menina Lendo', c.id, 34.9, '📖 Uma menina deitada lendo, com o vasinho ao lado do livro. Peça de estante para quem conta os dias pela próxima leitura.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vasinho
1 figura com livro
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 13 cm (cerca de 13 × 6 × 8 cm)
Peso: aproximadamente 61 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta pequena.
Serve de presente?
Para leitores, professoras e bibliotecárias.', true, 30, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-menina-lendo-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-menina-lendo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-menina-lendo-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-menina-lendo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-menina-lendo-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-menina-lendo';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 61.0, 2.1, 'suposição' from public.produtos where slug = 'vaso-menina-lendo' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-pensador', 'MIM-PENS01', 'Vaso Pensador', c.id, 34.9, '🤔 A pose clássica do pensador, agora com uma planta na cabeça. Vai bem na mesa de quem vive tendo ideias.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso pensador
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 8 × 6 × 10 cm
Peso: aproximadamente 59 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta pequena ou cacto.
Tem furo embaixo?
Não. Regue com pouca água.', true, 31, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-pensador-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-pensador';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-pensador-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-pensador';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 59.0, 2.7, 'suposição' from public.produtos where slug = 'vaso-pensador' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-de-parede-rosto-de-mulher', 'MIM-ROST01', 'Vaso de Parede Rosto de Mulher', c.id, 40.9, '🌿 Um rosto sereno na parede e a planta caindo como cabelo. Com jiboia ou samambaia, vira escultura viva.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso de parede
Fixação:
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 10 × 6 × 12 cm
Peso: aproximadamente 74 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Como fixa?
Por furo no verso, com parafuso .
Que planta combina?
Jiboia, samambaia pequena, dinheiro em penca e colar de pérolas.', true, 32, array['Aniversário','Bichinho e personagem','Casa nova','De parede','Quem ama plantas']::text[], 'De parede', false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-de-parede-rosto-de-mulher-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-de-parede-rosto-de-mulher';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-de-parede-rosto-de-mulher-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-de-parede-rosto-de-mulher';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-de-parede-rosto-de-mulher-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-de-parede-rosto-de-mulher';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 74.0, 3.21, 'suposição' from public.produtos where slug = 'vaso-de-parede-rosto-de-mulher' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-xicara-barista', 'MIM-BARI01', 'Vaso Xícara Barista', c.id, 27.9, '☕ Uma xicarazinha sorridente que troca o café por uma suculenta. Fica na mesa de trabalho, na cozinha ou no cantinho do café.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso xícara com carinha
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: cerca de 6 cm (cerca de 7 × 6 × 6 cm)
Peso: aproximadamente 42 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto de muda pequena.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 33, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas','Sai em lote']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-xicara-barista-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-xicara-barista';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-xicara-barista-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-xicara-barista';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-xicara-barista-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-xicara-barista';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 42.0, 1.46, 'suposição' from public.produtos where slug = 'vaso-xicara-barista' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-carinha-feliz-mini', 'MIM-HAPP01', 'Vaso Carinha Feliz Mini', c.id, 35.9, '😊 Um vasinho que sorri toda vez que você olha. Pequeno, alegre e perfeito para uma suculenta só.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 mini vaso com carinha
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 7 × 7 × 7 cm
Peso: aproximadamente 65 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta ou cacto de muda.
Serve de brinde?
Sim. Para quantidade, chame a gente no WhatsApp.', true, 34, array['Aniversário','Bichinho e personagem','Casa nova','Quem ama plantas','Sai em lote']::text[], null, false, array['bichinho']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-mini-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-carinha-feliz-mini';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-mini-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-carinha-feliz-mini';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-carinha-feliz-mini-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-carinha-feliz-mini';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 65.0, 2.1, 'suposição' from public.produtos where slug = 'vaso-carinha-feliz-mini' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-arvore-espiral', 'MIM-ARVO01', 'Vaso Árvore Espiral', c.id, 43.9, '🌳 Os galhos sobem em espiral e formam o próprio vaso, como um tronco torcido. Com uma suculenta em cima, parece uma arvorezinha.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso árvore espiral com furo de drenagem
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10 cm de altura
Peso: aproximadamente 82 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo. Prato não acompanha

🧼 CUIDADOS
Regar sobre um pratinho ou na pia e deixar escorrer.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Vem com prato?
Não. Use um pratinho embaixo na hora de regar.
Cabe que planta?
Suculentas, cactos e mudas pequenas.', true, 35, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-arvore-espiral-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-arvore-espiral-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-arvore-espiral-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-arvore-espiral';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 82.0, 3.75, 'suposição' from public.produtos where slug = 'vaso-arvore-espiral' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-autoirrigavel-com-indicador-de-agua', 'MIM-INDI01', 'Vaso Autoirrigável com Indicador de Água', c.id, 89.9, '💧 Um indicador sobe e desce mostrando quanta água ainda tem no reservatório. Você sabe a hora de encher sem enfiar o dedo na terra.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso externo com reservatório
1 vaso interno
1 indicador de nível
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 9,1 × 9,1 × 7,2 cm
Peso: aproximadamente 193 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Rega: autoirrigável, com reservatório de água

🧼 CUIDADOS
Encher o reservatório só com água. Esvaziar antes de mudar o vaso de lugar.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Serve para planta carnívora?
Serve, e é para elas que o vaso foi pensado: gostam de substrato sempre úmido.
Vaza?', true, 36, array['Aniversário','Autoirrigável','Casa nova','Moderno','Quem ama plantas']::text[], 'Autoirrigável', false, array['autoirrigavel','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-autoirrigavel-com-indicador-de-agua-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-autoirrigavel-com-indicador-de-agua-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-autoirrigavel-com-indicador-de-agua-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 193.0, 5.32, 'suposição' from public.produtos where slug = 'vaso-autoirrigavel-com-indicador-de-agua' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-canelado-curvo', 'MIM-CURV01', 'Vaso Canelado Curvo', c.id, 47.9, '🪴 Nervuras que se curvam do pé até a boca, num desenho orgânico e macio de olhar. Combina com madeira, linho e muita planta.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso canelado curvo
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10 cm (altura SUPOSIÇÃO 9 cm)
Peso: aproximadamente 99 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.
Tem outros tamanhos?
O modelo existe em 6, 8 e 12 cm. Chame a gente no WhatsApp.', true, 37, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-curvo-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-curvo-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-curvo-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-canelado-curvo';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 99.0, 3.1, 'suposição' from public.produtos where slug = 'vaso-canelado-curvo' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-canelado-redondo', 'MIM-CANE01', 'Vaso Canelado Redondo', c.id, 43.9, '🪴 Linhas verticais suaves em volta de um vaso baixo e redondo. Deixa qualquer suculenta com cara de loja de decoração.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso canelado redondo
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 8 cm de diâmetro (altura SUPOSIÇÃO 7 cm)
Peso: aproximadamente 83 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Não. É um cachepô: coloque a planta no vasinho plástico dela e apoie dentro.
Qual o tamanho da boca?
Cerca de 7 cm por dentro, SUPOSIÇÃO. Serve para muda em pote 6.', true, 38, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-redondo-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-redondo-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-canelado-redondo-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-canelado-redondo';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 83.0, 3.64, 'suposição' from public.produtos where slug = 'vaso-canelado-redondo' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-com-pes', 'MIM-PESV01', 'Vaso com Pés', c.id, 41.9, '🌱 Um vaso que parece móvel de design, com pezinhos finos que deixam a peça leve na mesa. Fica bonito sozinho ou em trio na estante.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso com 3 pés já colados
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: boca de 7,2 cm (medidas externas SUPOSIÇÃO 8,5 × 8,5 × 9 cm)
Peso: aproximadamente 77 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Não. É um cachepô: coloque a planta no vasinho plástico dela e apoie dentro.
Tem tamanho maior?
Por enquanto só este. Chame a gente no WhatsApp se precisar de outro.', true, 39, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-pes-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-com-pes';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-pes-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-com-pes';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-pes-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-com-pes';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-com-pes';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-com-pes';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-com-pes';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-com-pes';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-com-pes';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 77.0, 3.57, 'suposição' from public.produtos where slug = 'vaso-com-pes' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-coracao-com-maos', 'MIM-CORM01', 'Vaso Coração com Mãos', c.id, 28.9, '💜 Duas mãozinhas fazendo coração, com espaço para uma suculenta ou planta aérea no meio. É presente pequeno que fica na mesa de quem recebe por muito tempo.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso coração com mãos
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 6 cm (medidas externas SUPOSIÇÃO 7 × 6 × 6 cm)
Peso: aproximadamente 45 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Cabe que planta?
Suculenta pequena, cacto de muda ou planta aérea (tillandsia). A boca tem cerca de 4 cm, SUPOSIÇÃO.
A planta vem junto?
Não. A planta das fotos não acompanha o produto.', true, 40, array['Aniversário','Casa nova','Dia das Mães','Dia dos Namorados','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coracao-com-maos-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coracao-com-maos-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-coracao-com-maos-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-coracao-com-maos';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 45.0, 1.67, 'suposição' from public.produtos where slug = 'vaso-coracao-com-maos' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-espiral-afunilado', 'MIM-ESPF01', 'Vaso Espiral Afunilado', c.id, 43.9, '🌀 Base estreita, barriga larga e boca fechando de novo, tudo girando em espiral. Um vaso com cara de peça de design.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso espiral afunilado
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 9 × 9 × 9 cm
Peso: aproximadamente 79 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: sem furo. Funciona como cachepô, com o vasinho plástico da planta dentro

🧼 CUIDADOS
Regar a planta fora do cachepô ou com pouca água. A peça não foi feita para segurar água parada.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Não. Use como cachepô, com o vasinho plástico da planta dentro.
Qual o tamanho?
9 cm de altura e 9 cm na parte mais larga.', true, 41, array['Aniversário','Casa nova','Moderno','Quem ama plantas']::text[], null, false, array['moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-espiral-afunilado-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-espiral-afunilado-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-espiral-afunilado-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-espiral-afunilado';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 79.0, 4.09, 'suposição' from public.produtos where slug = 'vaso-espiral-afunilado' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-gotejamento-hexarain', 'MIM-GOTE01', 'Vaso Gotejamento HexaRain', c.id, 138.9, '💧 O reservatório no alto solta a água em gotas, devagar, direto na terra. Parece uma chuvinha e deixa a planta regada por dias.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 estrutura com reservatório de água
1 copo para a planta
1 prato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 15 × 15 × 20 cm (não informado na página)
Peso: aproximadamente 332 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Rega: autoirrigável, com reservatório de água

🧼 CUIDADOS
Encher o reservatório só com água. Esvaziar antes de mudar o vaso de lugar.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Quanto tempo dura a água?

Vaza?', true, 42, array['Aniversário','Autoirrigável','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Autoirrigável', false, array['autoirrigavel','pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gotejamento-hexarain-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gotejamento-hexarain-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-gotejamento-hexarain-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-gotejamento-hexarain';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 332.0, 7.11, 'suposição' from public.produtos where slug = 'vaso-gotejamento-hexarain' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-japandi-autoirrigavel', 'MIM-JAPA01', 'Vaso Japandi Autoirrigável', c.id, 112.9, '💧 A planta bebe sozinha do reservatório e você rega bem menos vezes. O desenho japandi, reto e calmo, combina com sala, escritório e cozinha.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso interno
1 base com reservatório de água
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: SUPOSIÇÃO 13 × 13 × 13 cm (conferir no fatiador)
Peso: aproximadamente 238 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Rega: autoirrigável, com reservatório de água

🧼 CUIDADOS
Encher o reservatório só com água. Esvaziar antes de mudar o vaso de lugar.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
De quanto em quanto tempo rego?
Depende da planta e do clima. O reservatório segura alguns dias de água; confira o nível pela borda.
Vaza?', true, 43, array['Aniversário','Autoirrigável','Casa nova','Moderno','Quem ama plantas']::text[], 'Autoirrigável', false, array['autoirrigavel','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-japandi-autoirrigavel-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-japandi-autoirrigavel-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-japandi-autoirrigavel-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-japandi-autoirrigavel';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 238.0, 8.23, 'suposição' from public.produtos where slug = 'vaso-japandi-autoirrigavel' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-kinetic-com-prato', 'MIM-KINE01', 'Vaso Kinetic com Prato', c.id, 72.9, '🌿 As ondas do vaso parecem se mexer quando você passa. Ele fica suspenso sobre o prato, que recolhe a água da rega.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso com furo de drenagem
1 prato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10,7 × 10,7 × 8 cm
Peso: aproximadamente 149 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Posso escolher cor diferente para o prato?
Por enquanto vai na mesma cor. Chame a gente no WhatsApp para combinar duas cores.
Cabe que planta?
Suculentas, peperômia, jiboia e mudas pequenas.', true, 44, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-kinetic-com-prato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-kinetic-com-prato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-kinetic-com-prato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-kinetic-com-prato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 149.0, 8.3, 'suposição' from public.produtos where slug = 'vaso-kinetic-com-prato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-papel-amassado-com-prato', 'MIM-PAPE01', 'Vaso Papel Amassado com Prato', c.id, 79.9, '📄 Parece uma folha de papel amassada que virou vaso. A textura chama atenção na estante e combina com planta de folha grande ou suculenta.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso efeito papel amassado com furos de drenagem
1 prato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: área de plantio de 8,5 cm (medidas externas SUPOSIÇÃO 10 × 10 × 9,5 cm)
Peso: aproximadamente 185 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Tem furo embaixo?
Tem, e vem com prato para segurar a água.
É macio como papel?
Não. É rígido, impresso em PLA. Só a aparência é de papel.', true, 45, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-papel-amassado-com-prato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-papel-amassado-com-prato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-papel-amassado-com-prato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-papel-amassado-com-prato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 185.0, 5.71, 'suposição' from public.produtos where slug = 'vaso-papel-amassado-com-prato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-com-prato-12-cm', 'MIM-PRAT01', 'Vaso com Prato 12 cm', c.id, 61.9, '🌿 Um vaso simples, leve e com prato, no tamanho certo para temperos, samambaia pequena e suculentas. Bom para a janela da cozinha.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso com furo de drenagem
1 prato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: boca de 12,5 cm (externas SUPOSIÇÃO 13,5 × 13,5 × 11 cm)
Peso: aproximadamente 125 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
É resistente?
É leve e flexiona um pouco vazio. Com terra, fica firme.
Posso usar na varanda?
Sim, desde que não pegue sol direto no meio do dia.', true, 46, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-prato-12-cm-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-prato-12-cm-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-com-prato-12-cm-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-com-prato-12-cm';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 125.0, 5.99, 'suposição' from public.produtos where slug = 'vaso-com-prato-12-cm' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-quadrado-com-prato', 'MIM-QUAD01', 'Vaso Quadrado com Prato', c.id, 65.9, '⬜ Linhas retas e cantos suaves para quem gosta de decoração limpa. Vem com prato e furos que deixam a água sair sem levar a terra.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso quadrado com furos de drenagem
1 prato
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: boca de 10 cm (externas SUPOSIÇÃO 11,5 × 11,5 × 10 cm)
Peso: aproximadamente 145 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Drenagem: com furo no fundo e prato para a água

🧼 CUIDADOS
Regar e deixar a água sair no prato. Esvaziar o prato se acumular.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
A terra escapa pelo furo?
Os furos são pequenos e desenhados para segurar a terra e deixar passar a água.
Cabe que planta?
Muda em pote de até 10 cm.', true, 47, array['Aniversário','Casa nova','Com pratinho','Moderno','Quem ama plantas']::text[], 'Com pratinho', false, array['pratinho','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-quadrado-com-prato-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-quadrado-com-prato-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-quadrado-com-prato-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-quadrado-com-prato';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 145.0, 4.57, 'suposição' from public.produtos where slug = 'vaso-quadrado-com-prato' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'vaso-wabi-sabi-autoirrigavel', 'MIM-WABI01', 'Vaso Wabi Sabi Autoirrigável', c.id, 90.9, '💧 Textura irregular de cerâmica feita à mão, com rega por pavio escondida por dentro. A planta puxa só a água que precisa e não encharca.

Tem em cinco cores: Branco, Bege, Verde oliva, Marrom ou Preto.

📦 O QUE VEM NO PEDIDO
1 vaso externo com reservatório
1 inserto interno para a planta
Pavio
A planta das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 10 cm (medidas externas SUPOSIÇÃO 10 × 10 × 10 cm)
Peso: aproximadamente 207 g
Cores: Branco, Bege, Verde oliva, Marrom ou Preto
Rega: autoirrigável, com reservatório de água

🧼 CUIDADOS
Encher o reservatório só com água. Esvaziar antes de mudar o vaso de lugar.
Limpar com pano úmido.
Para uso em ambiente interno. Não deixar ao sol direto nem dentro do carro: o PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Como funciona o pavio?
O cordão sai do fundo da terra e mergulha no reservatório. A água sobe por capilaridade.
Vaza?', true, 48, array['Aniversário','Autoirrigável','Casa nova','Moderno','Quem ama plantas']::text[], 'Autoirrigável', false, array['autoirrigavel','moderno']::text[] from public.categorias c where c.slug = 'vasos-de-planta' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-wabi-sabi-autoirrigavel-1.jpg', 'criador', 0 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-wabi-sabi-autoirrigavel-2.jpg', 'criador', 1 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/vaso-wabi-sabi-autoirrigavel-3.jpg', 'criador', 2 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 1 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 4 from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 207.0, 3.03, 'suposição' from public.produtos where slug = 'vaso-wabi-sabi-autoirrigavel' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'chaveiro-camera-instantanea', 'MIM-CAMI01', 'Chaveiro Câmera Instantânea', c.id, 14.9, '📸 Uma câmera instantânea em miniatura para pendurar na bolsa, na mochila ou nas chaves. Empurre a lateral e a foto sobe pela parte de cima, como se tivesse acabado de ser revelada.

Tem em sete cores: branco, preto, rosa bebê, rosa escuro, azul bebê, verde e roxo ametista. Um presente criativo para a amiga, a namorada ou para quem ama fotografia 💕

📦 O QUE VEM NO PEDIDO
1 chaveiro câmera na cor escolhida
1 cartão de foto em branco, que sobe e desce dentro da câmera
1 corrente com argola de chaveiro
A foto não acompanha: recorte a sua e cole no cartão

📏 FICHA TÉCNICA
Material: PLA, plástico de origem vegetal, e corrente metálica
Tamanho da câmera: aproximadamente 4,5 × 5,0 cm, com 1,8 cm de espessura
Peso: aproximadamente 25 g, com a corrente
Cores: branco, preto, rosa bebê, rosa escuro, azul bebê, verde e roxo ametista

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.

💬 PERGUNTAS FREQUENTES
A foto vem junto? Não. Recorte uma foto no tamanho do cartão e cole.
Vocês imprimem a foto? Ainda não. Chame a gente no WhatsApp se quiser várias unidades.
Quero mais de uma cor. É só adicionar cada cor ao carrinho.', true, 49, array['Amiga ou amigo','Amigo secreto','Aniversário','Colega de trabalho','Criança','Dia das Crianças','Kit','Lembrança de festa','Sai em lote']::text[], 'A foto sobe', true, '{}'::text[] from public.categorias c where c.slug = 'chaveiros' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/chaveiro-camera-instantanea-1.jpg', 'excecao', 0 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/chaveiro-camera-instantanea-2.jpg', 'excecao', 1 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.produto_videos (produto_id, caminho, ordem) select id, 'assets/videos/chaveiro-camera-instantanea.mp4', 0 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa escuro', 0 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 2 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 3 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 4 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 5 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 6 from public.produtos where slug = 'chaveiro-camera-instantanea';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'chaveiro-camera-porta-foto-3x4', 'MIM-CAMF01', 'Chaveiro Câmera Porta Foto 3x4', c.id, 98.9, '📸 Uma câmera de verdade em miniatura para levar a foto de quem você ama no chaveiro. É só colocar uma foto 3x4 dentro e ela aparece em cima da câmera, como se tivesse acabado de ser tirada.

Vem em kits de 5, 10 ou 20 unidades, na cor que você escolher: rosa, azul bebê, branco, verde, amarelo, bege ou roxo ametista. Fica lindo como lembrança de casamento, aniversário, chá de bebê, formatura ou para presentear a turma toda 💕

📦 O QUE VEM NO PEDIDO
Chaveiros de câmera na quantidade e na cor escolhidas
1 corrente com argola de chaveiro em cada câmera
A foto não acompanha: você coloca a sua

📏 FICHA TÉCNICA
Material: PLA, plástico de origem vegetal, e corrente metálica
Tamanho da câmera: 4,6 × 5,0 cm, com 1 cm de espessura
Foto: tamanho 3x4
Peso: aproximadamente 38 g por unidade, com a corrente
Cores: rosa, azul bebê, branco, verde, amarelo, bege e roxo ametista

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.

💬 PERGUNTAS FREQUENTES
A foto vem junto? Não. Recorte uma foto 3x4 e coloque dentro da câmera.
Posso misturar cores no kit? Cada kit vem numa cor só. Para misturar, compre kits separados ou chame a gente no WhatsApp.
Precisa de mais de 20? Chame a gente no WhatsApp.', true, 50, array['Colega de trabalho','Criança','Dia das Crianças','Formatura','Kit','Lembrança de festa','Sai em lote']::text[], 'Kits de 5, 10 e 20', true, '{}'::text[] from public.categorias c where c.slug = 'chaveiros' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/chaveiro-camera-porta-foto-3x4-1.jpg', 'real', 0 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/chaveiro-camera-porta-foto-3x4-2.jpg', 'real', 1 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/chaveiro-camera-porta-foto-3x4-3.jpg', 'real', 2 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.produto_videos (produto_id, caminho, ordem) select id, 'assets/videos/chaveiro-camera-porta-foto-3x4.mp4', 0 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa', 0 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 1 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 2 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 5 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 6 from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 170.25, 5.92, 'fatiador' from public.produtos where slug = 'chaveiro-camera-porta-foto-3x4' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'porta-chaves-arco-canelado-com-prateleira', 'MIM-PCHA01', 'Porta Chaves Arco Canelado com Prateleira', c.id, 79.9, '🔑 Chegou em casa, chave no lugar. O porta chaves com arco canelado organiza a entrada e ainda tem uma prateleira para planta, óculos ou carteira.

Tem em cinco cores: Branco, Preto, Verde oliva, Marrom e Bege.

📦 O QUE VEM NO PEDIDO
1 porta chaves com prateleira e 6 ganchos
Parafusos e buchas para instalar na parede
Vaso, planta e chaves das fotos não acompanham o produto

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Medidas: 23,3 cm de largura, 22,9 cm de altura e 9,2 cm de profundidade
Peso: aproximadamente 190 g
Ganchos: 6
Fixação: parafuso e bucha (acompanham)
Cores: Branco, Preto, Verde oliva, Marrom ou Bege

🧼 CUIDADOS
Limpar com pano seco.
Não instalar onde bate sol direto. O PLA pode deformar em temperatura alta.', true, 51, array['Amiga ou amigo','Aniversário','Casa nova','De parede','Mãe']::text[], '6 ganchos', false, '{}'::text[] from public.categorias c where c.slug = 'casa-e-organizacao' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-chaves-arco-canelado-com-prateleira-1.jpg', 'excecao', 0 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-chaves-arco-canelado-com-prateleira-2.jpg', 'excecao', 1 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/porta-chaves-arco-canelado-com-prateleira-3.jpg', 'excecao', 2 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Branco', 0 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 1 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde oliva', 2 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Marrom', 3 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Bege', 4 from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 187.44, 5.25, 'fatiador' from public.produtos where slug = 'porta-chaves-arco-canelado-com-prateleira' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'organizador-de-pratos-vertical', 'MIM-PPRA01', 'Organizador de Pratos Vertical', c.id, 29.9, '🍽️ Pratos em pé, armário organizado. O organizador vertical guarda os pratos lado a lado, facilita pegar um sem tirar a pilha toda e aproveita melhor o espaço do armário.

Base firme e baixa, com pinos que seguram cada prato separado.

📦 O QUE VEM NO PEDIDO
1 organizador de pratos na cor Preto
Os pratos das fotos não acompanham o produto

📏 FICHA TÉCNICA
Material: PLA
Medidas: 20,3 cm × 18 cm × 4 cm de altura
Peso: aproximadamente 121 g
Cor: Preto
Uso: dentro do armário ou sobre a bancada, com pratos secos

🧼 CUIDADOS
Guardar os pratos secos e frios. A peça não é escorredor.
Não levar à lava-louças. Lavar à mão com água fria e sabão neutro.
PLA deforma com calor: longe do fogão, do forno e do sol direto.

💬 PERGUNTAS FREQUENTES
Posso usar como escorredor?
Não. Ele foi feito para guardar pratos já secos.
Tem em outras cores?
Por enquanto só em Preto. Chame a gente no WhatsApp se quiser outra cor.', true, 52, array['Casa nova']::text[], null, false, '{}'::text[] from public.categorias c where c.slug = 'casa-e-organizacao' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/organizador-de-pratos-vertical-1.jpg', 'excecao', 0 from public.produtos where slug = 'organizador-de-pratos-vertical';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Preto', 0 from public.produtos where slug = 'organizador-de-pratos-vertical';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'estrela-do-mar-fidget', 'MIM-FDEM01', 'Estrela do Mar Fidget', c.id, 35.9, '⭐ Estrela do Mar Fidget 3D: antiestresse, foco e relaxamento

✨ Uma estrela que cabe na mão e não para quieta.

A Estrela do Mar da Mimori é ideal para pessoas com TDAH, TEA, hiperfoco, ansiedade ou para quem busca momentos de relaxamento durante o trabalho, os estudos ou o lazer. Ela é toda coberta por pequenas escamas articuladas: aperte, dobre, torça e sinta cada pecinha se mexer.

🌊 SENSAÇÃO QUE ACALMA
O toque nas escamas ajuda a:
✔ Aliviar o estresse do dia
✔ Acalmar a cabeça nos momentos de tensão
✔ Manter o foco enquanto as mãos se ocupam
✔ Fazer uma pausa sem pegar o celular

🖐️ FÁCIL E GOSTOSA DE USAR
✔ Dobra para todos os lados
✔ Textura agradável, sem pontas
✔ Leve e fácil de levar na bolsa ou na mochila
Perfeita para reuniões, estudos, home office e aquela pausa entre uma tarefa e outra.

🎨 8 CORES PARA ESCOLHER
Roxo, laranja, amarelo, verde, vermelho, azul bebê, rosa bebê e verde e roxo.

💎 QUALIDADE QUE VOCÊ VÊ E SENTE
✔ Impressão 3D em alta definição
✔ PLA, plástico de origem vegetal, leve e resistente
✔ Peça única articulada: nada para montar
✔ Produzida pela Mimori, peça por peça

🎯 INDICADA PARA
✔ Quem quer aliviar o estresse no dia a dia
✔ Pessoas inquietas, que precisam ocupar as mãos para se concentrar
✔ Crianças, jovens e adultos
✔ Presente criativo, diferente e bonito de dar

📏 ESPECIFICAÇÕES
Tamanho: aproximadamente 14 x 11 cm
Peso: aproximadamente 45 g
Material: PLA

🧼 CUIDADOS
Limpar com pano seco. Não deixar ao sol direto ou dentro do carro.
Não é brinquedo para bebês. Menores de 3 anos só com supervisão de um adulto, porque tem partes pequenas.', true, 53, array['Amiga ou amigo','Amigo secreto','Colega de trabalho','Criança','Dia das Crianças','Lembrança de festa','Sensorial']::text[], '8 cores', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-do-mar-fidget-1.jpg', 'excecao', 0 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo', 0 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 1 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 2 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 4 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 5 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 6 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde e roxo', 7 from public.produtos where slug = 'estrela-do-mar-fidget';
insert into public.produto_custos (produto_id, gramas, horas, fonte) select id, 45, 3, 'suposição' from public.produtos where slug = 'estrela-do-mar-fidget' on conflict (produto_id) do nothing;
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'ovo-de-dragao-fidget', 'MIM-FDOV01', 'Ovo de Dragão Fidget', c.id, 21.7, '🐉 Um ovo de dragão que abre em espiral! Fechado, decora a mesa. Na mão, gira, abre e fecha, e ajuda a descarregar a tensão.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 54, array['Dia das Crianças','Sensorial']::text[], 'Abre em espiral', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/ovo-de-dragao-fidget-1.jpg', 'excecao', 0 from public.produtos where slug = 'ovo-de-dragao-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'estrela-sensorial-fidget', null, 'Estrela Sensorial Fidget', c.id, 19.9, '⭐ Uma estrela de camadas que gira e se expande em espiral quando você empurra o centro. Solte e ela volta a ficar plana.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 55, array['Dia das Crianças','Sensorial']::text[], 'Gira e expande', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-sensorial-fidget-1.jpg', 'excecao', 0 from public.produtos where slug = 'estrela-sensorial-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-sensorial-fidget-2.jpg', 'excecao', 1 from public.produtos where slug = 'estrela-sensorial-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-sensorial-fidget-3.jpg', 'excecao', 2 from public.produtos where slug = 'estrela-sensorial-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'cubo-infinito-fidget', 'MIM-FDCI01', 'Cubo Infinito Fidget', c.id, 21.9, 'Um cubo que dobra para sempre. Cantos arredondados que a mão não quer soltar.

O Cubo Infinito Fidget tem oito cubinhos ligados por articulações. Na mão, ele dobra, abre e fecha num movimento contínuo, sem começo e sem fim. Dobre ao meio, abra pelo outro lado, gire de novo: cada movimento revela um formato novo e ele sempre volta a ser cubo.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 56, array['Dia das Crianças','Sensorial']::text[], 'Dobra sem fim', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cubo-infinito-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cubo-infinito-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cubo-infinito-fidget-3.jpg', 'criador', 2 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'cubo-infinito-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'giroscopio-fidget-4-aneis', 'MIM-FDGI01', 'Giroscópio Fidget 4 Anéis', c.id, 14.9, 'Quatro anéis girando ao mesmo tempo. Uma pausa de segundos que muda o dia.

O Giroscópio Fidget tem quatro anéis, um dentro do outro, cada um girando num eixo diferente. Pequeno, leve e sempre à mão. Segure pelo anel de fora e gire o de dentro: os anéis rodam em direções diferentes e formam uma esfera em movimento.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 57, array['Dia das Crianças','Sensorial']::text[], '4 anéis giram', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/giroscopio-fidget-4-aneis-1.jpg', 'criador', 0 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'giroscopio-fidget-4-aneis';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'fidget-click-clack', 'MIM-FDCK01', 'Fidget Click Clack', c.id, 15.9, 'Click, clack e um deslizar macio na mesma peça. Três jeitos de descarregar a tensão.

O Fidget Click Clack junta três movimentos numa peça só: uma roda que gira com clique, uma trava que faz clack e um deslizar suave. Gire, trave, deslize e comece de novo.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 58, array['Dia das Crianças','Sensorial']::text[], 'Clique e deslize', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'fidget-click-clack';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'fidget-click-clack';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'cambio-de-marchas-fidget', 'MIM-FDCB01', 'Câmbio de Marchas Fidget', c.id, 17.9, 'Troque de marcha sem sair da mesa. Cada engate com um clique firme.

O Câmbio de Marchas Fidget imita uma alavanca de câmbio: a alavanca entra em cada marcha com um estalo e volta ao centro pela mola. Engate, solte, engate a próxima.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 59, array['Dia das Crianças','Sensorial']::text[], '5 marchas e ré', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cambio-de-marchas-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cambio-de-marchas-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'cambio-de-marchas-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'aneis-tateis-fidget', 'MIM-FDAN01', 'Anéis Táteis Fidget', c.id, 17.9, 'Anéis com textura que giram entre os dedos. O toque já acalma.

Os Anéis Táteis Fidget formam uma pequena esfera de anéis que giram uns dentro dos outros, com textura em relevo para sentir na ponta dos dedos.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 60, array['Dia das Crianças','Sensorial']::text[], 'Anéis com textura', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/aneis-tateis-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/aneis-tateis-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/aneis-tateis-fidget-3.jpg', 'criador', 2 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'aneis-tateis-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'medusa-fidget-articulada', 'MIM-FDMD01', 'Medusa Fidget Articulada', c.id, 27.9, 'Uma água-viva de 16 tentáculos que escorrem pela mão. Mexe, enrola e vira espiral na mesa.

A Medusa Fidget Articulada tem um corpo liso com relevo e 16 tentáculos feitos de elos que dobram para todos os lados. Deixe os tentáculos escorrerem entre os dedos ou espalhe na mesa e monte uma espiral.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 61, array['Dia das Crianças','Sensorial']::text[], '16 tentáculos', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/medusa-fidget-articulada-1.jpg', 'criador', 0 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/medusa-fidget-articulada-2.jpg', 'criador', 1 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/medusa-fidget-articulada-3.jpg', 'criador', 2 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'medusa-fidget-articulada';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'cone-espiral-fidget', 'MIM-FDCE01', 'Cone Espiral Fidget', c.id, 28.9, 'Duas espirais que atravessam uma a outra. Um giro que acalma só de olhar.

O Cone Espiral Fidget são duas peças em espiral que se encaixam. Uma passa por dentro da outra num giro suave, e parece que não deveria caber.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 62, array['Dia das Crianças','Sensorial']::text[], 'Duas espirais', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cone-espiral-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cone-espiral-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'cone-espiral-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'cone-impossivel-fidget', 'MIM-FDCP01', 'Cone Impossível Fidget', c.id, 28.9, 'Uma peça que atravessa a outra. Parece impossível, e é isso que prende o olhar.

O Cone Impossível Fidget são duas peças em espiral: a de dentro atravessa a de fora girando. Gire e veja ela passar, volta por volta, até sair do outro lado.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 63, array['Dia das Crianças','Sensorial']::text[], 'Uma passa na outra', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cone-impossivel-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/cone-impossivel-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'cone-impossivel-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'bola-twisty-fidget', 'MIM-FDBT01', 'Bola Twisty Fidget', c.id, 23.9, 'Uma bola que se abre em espiral. Fechada, enfeita. Na mão, hipnotiza.

A Bola Twisty Fidget é feita de gomos que deslizam em espiral em volta do centro. Segure pela base e gire o topo: a bola se abre em espiral. Gire de volta e ela fecha.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 64, array['Dia das Crianças','Sensorial']::text[], 'Abre girando', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/bola-twisty-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/bola-twisty-fidget-2.jpg', 'criador', 1 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/bola-twisty-fidget-3.jpg', 'criador', 2 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'bola-twisty-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'estrela-fidget-10-pontas', 'MIM-FDEP01', 'Estrela Fidget 10 Pontas', c.id, 24.9, 'Uma estrela que se abre em espiral. Camadas que dançam na mão.

A Estrela Fidget 10 Pontas é feita em camadas finas em espiral. Na mesa, é uma estrela. Empurre pelo centro e as camadas se abrem em espiral.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 65, array['Dia das Crianças','Sensorial']::text[], 'Abre em espiral', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-fidget-10-pontas-1.jpg', 'criador', 0 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-fidget-10-pontas-2.jpg', 'criador', 1 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/estrela-fidget-10-pontas-3.jpg', 'criador', 2 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'estrela-fidget-10-pontas';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'tecido-sensorial-3d', 'MIM-FDTC01', 'Tecido Sensorial 3D', c.id, 33.9, 'Um tecido feito em 3D. Escorrega entre os dedos como pano.

O Tecido Sensorial 3D é uma malha de pequenas peças articuladas. Ele dobra, cai e se acomoda como um pano de verdade.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 66, '{}'::text[], 'Cai como tecido', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/tecido-sensorial-3d-1.jpg', 'criador', 0 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/tecido-sensorial-3d-2.jpg', 'criador', 1 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/tecido-sensorial-3d-3.jpg', 'criador', 2 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'tecido-sensorial-3d';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'minhoca-morf-fidget', 'MIM-FDMF01', 'Minhoca Morf Fidget', c.id, 31.9, 'Uma malha que estica, encolhe e muda de forma. Nunca para igual.

A Minhoca Morf Fidget é uma malha em espiral que se deforma na mão. Estica, encolhe, vira do avesso e volta.

💬 PERGUNTAS FREQUENTES
É brinquedo de criança? É um objeto antiestresse para jovens e adultos, a partir de 14 anos. Tem partes pequenas.
Como limpar? Com pano seco. Não deixe ao sol direto nem dentro do carro.', true, 67, array['Dia das Crianças','Sensorial']::text[], 'Muda de forma', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/minhoca-morf-fidget-1.jpg', 'criador', 0 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Roxo ametista', 0 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Rosa bebê', 1 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Azul bebê', 2 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Verde', 3 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Amarelo', 4 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Laranja', 5 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.variacoes (produto_id, cor, ordem) select id, 'Vermelho', 6 from public.produtos where slug = 'minhoca-morf-fidget';
insert into public.produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos) select 'jogo-da-memoria-das-cenouras', 'MIM-CENO01', 'Jogo da Memória das Cenouras', c.id, 119.9, '🥕 Jogo da Memória das Cenouras: brincadeira educativa para a família toda

Cada cenoura esconde uma cor na ponta, e só a folhinha fica de fora. A criança rola o dado, puxa uma cenoura e tenta lembrar onde está a cor da vez.

Tem dois modelos: Sem tampa, com tabuleiro, cenouras e dado, e Com tampa, que fecha o jogo e guarda tudo depois da partida.

🎲 COMO JOGAR
✔ Role o dado de cores. A cor que cair é a sua cor da vez.
✔ Puxe uma cenoura. Acertou a cor? Guarde e decida: parar ou arriscar mais uma.
✔ Errou a cor? Perde as cenouras da rodada.
✔ Quem juntar mais cenouras no final vence.

🧠 O QUE A BRINCADEIRA TRABALHA
✔ Memória e atenção: cada rodada revela uma cor, e quem presta atenção sai na frente
✔ Coordenação motora: puxar e plantar as cenouras de novo no tabuleiro
✔ Cores: 6 cores para reconhecer e nomear
✔ Momento sem tela, com todo mundo junto na mesa

🎨 6 CORES ESCONDIDAS
Vermelho, amarelo, verde, azul-claro, azul e rosa. São 4 cenouras de cada cor.

📦 O QUE VEM NO PEDIDO
Sem tampa: 1 tabuleiro redondo, 24 cenouras e 1 dado de cores
Com tampa: tudo isso e mais a tampa que fecha o jogo

📏 FICHA TÉCNICA
Material: PLA
Tabuleiro: 20 cm de diâmetro e 3 cm de altura
Peso: cerca de 450 g sem tampa e 820 g com tampa
Cores: tabuleiro, tampa e dado bege, cenouras laranja com folha verde e ponta nas 6 cores do jogo

ℹ️ INFORMAÇÕES IMPORTANTES
Recomendado a partir de 4 anos, com um adulto por perto.
Contém peças pequenas. Não indicado para menores de 3 anos.
A cor pode variar levemente de um lote para outro.

🧼 CUIDADOS
Limpar com pano seco. O PLA deforma no calor: não deixar no sol nem dentro do carro.

💬 PERGUNTAS FREQUENTES
Qual a diferença entre os modelos? O jogo é o mesmo. O Com tampa vem com a tampa que fecha e guarda as peças.
Quantas pessoas jogam? A partir de 2, e quanto mais gente, melhor.
Serve de presente? Sim, vai em caixa, pronto para entregar.

💜 POR QUE ESCOLHER A MIMORI
Nós fazemos cada peça aqui, com cuidado em cada detalhe, e respondemos no chat de verdade. Qualquer dúvida, é só chamar.', true, 68, array['Aniversário','Criança','Dia das Crianças','Natal','Sem tela']::text[], 'Sem tela', false, '{}'::text[] from public.categorias c where c.slug = 'jogos-e-fidget' on conflict (slug) do nothing;
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/jogo-da-memoria-das-cenouras-1.jpg', 'excecao', 0 from public.produtos where slug = 'jogo-da-memoria-das-cenouras';
insert into public.produto_fotos (produto_id, caminho, tipo, ordem) select id, 'assets/fotos/jogo-da-memoria-das-cenouras-2.jpg', 'excecao', 1 from public.produtos where slug = 'jogo-da-memoria-das-cenouras';
insert into public.produto_videos (produto_id, caminho, ordem) select id, 'assets/videos/jogo-da-memoria-das-cenouras.mp4', 0 from public.produtos where slug = 'jogo-da-memoria-das-cenouras';
