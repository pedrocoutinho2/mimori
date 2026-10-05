-- 007 · Opções com preço (kits e modelos), cores que faltavam, preços e limpeza de fotos
-- APLICADO em 04/10/2026 no projeto ydnanmpqwbjzskovnhyh (migração 007_opcoes_cores_precos_fotos), a pedido do Pedro.
-- Registro: 50-decisoes/2026-10-04-mimori-site-revisao-geral.md
-- Obs.: o passo 3 (Nossa Senhora, Branco para Azul claro) foi revertido no 008.

-- 1. opções com preço próprio (kit, modelo). Editáveis no painel /admin, bloco "Kits e opções".
create table if not exists produto_opcoes (
  id uuid primary key default gen_random_uuid(),
  produto_id uuid not null references produtos(id) on delete cascade,
  nome text not null,
  preco numeric(10,2) not null,
  ordem integer not null default 0
);
alter table produto_opcoes enable row level security;
create policy "site lê opções publicadas" on produto_opcoes for select using (exists (select 1 from produtos p where p.id = produto_opcoes.produto_id and (p.publicado or e_do_painel())));
create policy "painel grava opções" on produto_opcoes for all using (e_do_painel()) with check (e_do_painel());

insert into produto_opcoes (produto_id, nome, preco, ordem)
select p.id, o.nome, o.preco, o.ordem from produtos p join (values
  ('chaveiro-camera-porta-foto-3x4','Kit com 5',98.90,0),('chaveiro-camera-porta-foto-3x4','Kit com 10',169.90,1),('chaveiro-camera-porta-foto-3x4','Kit com 20',310.90,2),
  ('chaveiro-camera-instantanea','1 unidade',14.90,0),('chaveiro-camera-instantanea','Kit com 5 da mesma cor',58.90,1),('chaveiro-camera-instantanea','Kit com 5 cores sortidas',53.90,2),
  ('mini-jesus-sentado','1 unidade',17.90,0),('mini-jesus-sentado','2 unidades',23.90,1),('mini-jesus-sentado','3 unidades',35.90,2),('mini-jesus-sentado','4 unidades',44.90,3),
  ('jogo-da-memoria-das-cenouras','Sem tampa',119.90,0),('jogo-da-memoria-das-cenouras','Com tampa',169.90,1)
) as o(slug,nome,preco,ordem) on o.slug = p.slug;
update produtos set a_partir = true where slug = 'jogo-da-memoria-das-cenouras';

-- 2. cores dos vasos sem nenhuma (as 5 que a descrição promete)
insert into variacoes (produto_id, cor, ordem)
select p.id, m.cor, m.ord from produtos p join categorias c on c.id = p.categoria_id
cross join (values ('Branco',0),('Bege',1),('Verde oliva',2),('Marrom',3),('Preto',4)) as m(cor,ord)
where c.slug = 'vasos-de-planta' and not exists (select 1 from variacoes v where v.produto_id = p.id);

-- 3. Nossa Senhora (revertido no 008)
update variacoes v set cor = 'Azul claro' from produtos p where v.produto_id = p.id and p.slug = 'nossa-senhora-do-manto' and v.cor = 'Branco';

-- 4. Vaso Carinha Feliz: engine sem mão de obra (regra de 01/10 para os vasos)
update produtos set preco = 92.90 where slug = 'vaso-carinha-feliz';

-- 5. Letreiro: versão 2, a das fotos e do vídeo (peça real, cor única, R$ 22,90 de 28/09)
delete from variacoes v using produtos p where v.produto_id = p.id and p.slug = 'letreiro-ore-e-confie';
update produtos set sku = 'MIM-OREC02', preco = 22.90, descricao =
'🙏 Duas palavras que cabem na mesa e no dia inteiro. O letreiro Ore e Confie fica de pé sozinho na escrivaninha, na estante, na cabeceira ou no cantinho de oração.

A frase e confie vem em relevo, em outra cor, encaixada na palavra ORE.

📦 O QUE VEM NO PEDIDO
1 letreiro Ore e Confie
A bandeja das fotos não acompanha. Ela vem no Kit Ore e Confie, que também está no site.

📏 FICHA TÉCNICA
Material: PLA com acabamento fosco
Cores: base bege e frase em cinza, como nas fotos
Peso: aproximadamente 61 g

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.

💬 PERGUNTAS FREQUENTES
Serve para presente? Sim, e para quantidades maiores é só chamar a gente no WhatsApp.
A cor é igual à da foto? As fotos são da peça real, e o filamento muda um pouco com a luz do ambiente.'
where slug = 'letreiro-ore-e-confie';

-- 6. Jogo da Memória: tira o "chat" da Shopee
update produtos set descricao = replace(descricao, 'respondemos no chat de verdade', 'respondemos no WhatsApp de verdade') where slug = 'jogo-da-memoria-das-cenouras';

-- 7. fotos: duplicadas e com texto ou marca que não dá para cortar
delete from produto_fotos where caminho in (
  'assets/fotos/vaso-ninho-bicolor-2.jpg','assets/fotos/vaso-canelado-curvo-2.jpg','assets/fotos/vaso-papel-amassado-com-prato-2.jpg','assets/fotos/vaso-com-prato-12-cm-2.jpg',
  'assets/fotos/vaso-poligonal-com-prato-1.jpg','assets/fotos/vaso-dragao-dormindo-3.jpg','assets/fotos/vaso-xicara-barista-2.jpg','assets/fotos/vaso-leitora-aconchego-3.jpg',
  'assets/fotos/vaso-autoirrigavel-com-indicador-de-agua-1.jpg','assets/fotos/vaso-kinetic-com-prato-1.jpg');
