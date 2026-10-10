-- 015 · Preço por quantidade nos brindes para salão (10/10/2026)
-- Decisão: 50-decisoes/2026-10-10-mimori-preco-por-quantidade-brindes-salao.md
-- 10+ = custo/un do pedido de 10 (produção + embalagem diluída + MO) × 1,75; 20+ = custo/un do pedido de 20 × 1,4; 50+ a consultar.
-- Exceções do Pedro: Suporte de Celular Chaveiro 10+ fixado em 8,90 (custo cadastrado é da versão Padrão).
-- Preço da faixa vale para o preço base; nas opções o site aplica a mesma proporção, arredondando para ,90.

alter table public.produtos
  add column if not exists faixas jsonb not null default '[]'::jsonb,
  add column if not exists faixa_consulta integer;

comment on column public.produtos.faixas is 'Preço por quantidade sobre o preço base: [{"min":10,"preco":10.90},{"min":20,"preco":7.90}]';
comment on column public.produtos.faixa_consulta is 'A partir desta quantidade, valor a consultar no WhatsApp';

update public.produtos p set faixas = v.faixas::jsonb, faixa_consulta = 50
from (values
  ('porta-batom-florzinha',              '[{"min":10,"preco":10.90},{"min":20,"preco":7.90}]'),
  ('porta-retrato-coracao-de-trico',     '[{"min":10,"preco":6.90},{"min":20,"preco":5.90}]'),
  ('chaveiro-abridor-de-lata-esmalte',   '[{"min":10,"preco":7.90},{"min":20,"preco":5.90}]'),
  ('chaveiro-porta-escovinha-de-cilios', '[{"min":10,"preco":10.90},{"min":20,"preco":8.90}]'),
  ('porta-joias-com-bandeja-de-brincos', '[{"min":10,"preco":32.90},{"min":20,"preco":25.90}]'),
  ('bandeja-porta-treco-bolhas',         '[{"min":10,"preco":13.90},{"min":20,"preco":10.90}]'),
  ('chaveiro-porta-treco-de-bolsa',      '[{"min":10,"preco":11.90},{"min":20,"preco":8.90}]'),
  ('chaveiro-abridor-de-lata-beijo',     '[{"min":10,"preco":7.90},{"min":20,"preco":5.90}]'),
  ('chaveiro-abridor-de-lata-coracao',   '[{"min":10,"preco":7.90},{"min":20,"preco":6.90}]'),
  ('suporte-de-celular-chaveiro',        '[{"min":10,"preco":8.90},{"min":20,"preco":7.90}]'),
  ('suporte-de-celular-minimalista',     '[{"min":10,"preco":15.90},{"min":20,"preco":12.90}]'),
  ('pote-com-tampa-de-rosca',            '[{"min":10,"preco":12.90},{"min":20,"preco":9.90}]'),
  ('chaveiro-porta-anel-floral',         '[{"min":10,"preco":8.90},{"min":20,"preco":6.90}]'),
  ('chaveiro-caixinha-com-tampa',        '[{"min":10,"preco":9.90},{"min":20,"preco":7.90}]'),
  ('caixinha-coracao-de-trico-com-flor', '[{"min":10,"preco":14.90},{"min":20,"preco":11.90}]'),
  ('chaveiro-mini-camera-com-foto',      '[{"min":10,"preco":16.90},{"min":20,"preco":13.90}]'),
  ('chaveiro-coracao-giroscopio-fidget', '[{"min":10,"preco":9.90},{"min":20,"preco":7.90}]')
) as v(slug, faixas)
where p.slug = v.slug;

-- Bandeja Porta Joias Nuvem: sem custo cadastrado, sem faixa; só "a consultar" a partir de 10
update public.produtos set faixa_consulta = 10 where slug = 'bandeja-porta-joias-nuvem';

-- Dois blocos na página de brindes: lembrancinha para clientes e presente especial
update public.produtos set grupos = array_remove(grupos, 'presente') || '{lembrancinha}'
where slug in ('porta-batom-florzinha','porta-retrato-coracao-de-trico','chaveiro-abridor-de-lata-esmalte','chaveiro-porta-escovinha-de-cilios',
  'chaveiro-porta-treco-de-bolsa','chaveiro-abridor-de-lata-beijo','chaveiro-abridor-de-lata-coracao','suporte-de-celular-chaveiro',
  'pote-com-tampa-de-rosca','chaveiro-porta-anel-floral','chaveiro-caixinha-com-tampa','chaveiro-coracao-giroscopio-fidget')
  and not ('lembrancinha' = any(grupos));
update public.produtos set grupos = array_remove(grupos, 'lembrancinha') || '{presente}'
where slug in ('porta-joias-com-bandeja-de-brincos','bandeja-porta-treco-bolhas','bandeja-porta-joias-nuvem','suporte-de-celular-minimalista',
  'caixinha-coracao-de-trico-com-flor','chaveiro-mini-camera-com-foto')
  and not ('presente' = any(grupos));

-- Nomes corrigidos pelo Pedro
update public.produtos set nome = 'Chaveiro Porta Creme', slug = 'chaveiro-porta-creme',
  descricao = replace(replace(descricao,
    'Um potinho com tampa de rosca e enfeite em relevo, para pendurar na bolsa ou na mochila. Guarda bala, remédio, creme, grampo ou brinco.',
    'Um porta creme com tampa de rosca e enfeite em relevo, para pendurar na bolsa ou na mochila. Leva um pouquinho do creme preferido para onde for.'),
    '1 porta treco no enfeite', '1 porta creme no enfeite')
where slug = 'chaveiro-porta-treco-de-bolsa';

update public.produtos set nome = 'Bandeja Porta Joias Bolhas', slug = 'bandeja-porta-joias-bolhas',
  descricao = replace(descricao,
    'Uma bandeja redondinha com borda de bolhas para anéis, brincos, chaves e pequenos objetos.',
    'Uma bandeja de joias redondinha com borda de bolhas para anéis, brincos e colares.')
where slug = 'bandeja-porta-treco-bolhas';
