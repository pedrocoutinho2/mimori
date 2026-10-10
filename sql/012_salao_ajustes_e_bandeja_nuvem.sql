-- 012 · Brindes para salão: 8 produtos saem do site, porta treco vai para Chaveiros, entra a Bandeja Porta Joias Nuvem
-- APLICADO em 09/10/2026 no projeto ydnanmpqwbjzskovnhyh (migração 012_salao_ajustes_e_bandeja_nuvem), a pedido do Pedro.
-- Registro: 50-decisoes/2026-10-09-mimori-salao-ajustes-e-bandeja-nuvem.md
-- Os 8 produtos são despublicados, não apagados: fotos, variações e SKU continuam no banco para voltar se precisar.

update produtos set publicado = false, atualizado_em = now()
 where slug in ('suporte-de-celular','porta-anel-dinossauro','chaveiro-porta-joias-redondo','chaveiro-abridor-de-lata-redondo',
                'chaveiro-caixinha-coracao','porta-joias-de-viagem','mini-caixa-de-presente','chaveiro-rosa');

update produtos
   set categoria_id = (select id from categorias where slug = 'chaveiros'),
       ordem = 51,
       descricao = regexp_replace(descricao, E'💅 PARA O SEU SALÃO\\n[^\\n]*\\n\\n', ''),
       atualizado_em = now()
 where slug = 'chaveiro-porta-treco-com-tampa';

insert into produtos (slug, sku, nome, categoria_id, preco, descricao, publicado, ordem, tags, selo, a_partir, grupos)
select 'bandeja-porta-joias-nuvem', 'MIM-BJNU01', 'Bandeja Porta Joias Nuvem', c.id, 21.90,
E'☁️ Uma bandejinha em formato de nuvem, com borda arredondada, para anéis, brincos, colares, presilhas e chaves. Deixa a bancada do salão, a penteadeira ou a cabeceira arrumada e bonita.\n\nTem em dois tamanhos: a pequena, com 12 cm, para anéis e brincos, e a grande, para colar, presilha e chave.\n\n📦 O QUE VEM NO PEDIDO\n1 bandeja no tamanho e na cor escolhidos\n\n📏 FICHA TÉCNICA\nMaterial: PLA\nTamanho: pequena com 12 cm ou grande\nPeso: aproximadamente 40 g na pequena e 97 g na grande\nCores: Bege, Branco, Rosa bebê, Roxo ametista, Verde oliva ou Preto\n\n💅 PARA O SEU SALÃO\nPara dar às clientes em data especial, aniversário ou fidelidade, monte um kit a partir de 10 peças e chame a gente no WhatsApp para combinar cores e quantidade.\n\n⏱️ PRAZO\nProduzido em 3 a 5 dias úteis depois do pagamento.\n\n🧼 CUIDADOS\nLimpar com pano seco.\nNão deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.\n\n🎨 CRÉDITO\nModelo original de Emilio, publicado no MakerWorld.',
true, 86, array['Amiga ou amigo','Aniversário','Casa nova','Dia das Mães','Mãe'], '2 tamanhos', true, '{}'::text[]
from categorias c where c.slug = 'brindes-para-salao'
on conflict (slug) do nothing;

insert into produto_fotos (produto_id, caminho, tipo, ordem)
select p.id, f.caminho, 'criador', f.n - 1 from produtos p,
  unnest(array['assets/fotos/bandeja-porta-joias-nuvem-1.jpg','assets/fotos/bandeja-porta-joias-nuvem-2.jpg','assets/fotos/bandeja-porta-joias-nuvem-3.jpg']) with ordinality f(caminho, n)
where p.slug = 'bandeja-porta-joias-nuvem' and not exists (select 1 from produto_fotos x where x.produto_id = p.id);

insert into variacoes (produto_id, cor, ordem)
select p.id, v.cor, v.n - 1 from produtos p,
  unnest(array['Bege','Branco','Rosa bebê','Roxo ametista','Verde oliva','Preto']) with ordinality v(cor, n)
where p.slug = 'bandeja-porta-joias-nuvem' and not exists (select 1 from variacoes x where x.produto_id = p.id);

insert into produto_opcoes (produto_id, nome, preco, ordem)
select p.id, o.nome, o.preco, o.ordem from produtos p,
  (values ('Pequena, 12 cm', 21.90, 0), ('Grande', 48.90, 1)) o(nome, preco, ordem)
where p.slug = 'bandeja-porta-joias-nuvem' and not exists (select 1 from produto_opcoes x where x.produto_id = p.id);
