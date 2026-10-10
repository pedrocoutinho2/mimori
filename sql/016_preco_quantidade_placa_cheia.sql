-- 016 · Preço por quantidade recalculado com custo de placa cheia (10/10/2026)
-- Pedido do Pedro: no lote, a placa leva as peças juntas e o custo de produção por peça cai.
-- SUPOSIÇÃO até chegar o dado do fatiador: na placa cheia cada peça leva 25% menos tempo e gasta 1,8 g a menos (purga e linha de calibração rateadas).
-- 10+ = custo/un do pedido de 10 × 1,75; 20+ = custo/un do pedido de 20 × 1,4; terminado em ,90.
-- Suporte de Celular Chaveiro 10+ segue fixado em 8,90 (custo cadastrado é da versão Padrão).
update public.produtos p set faixas = v.faixas::jsonb
from (values
  ('porta-batom-florzinha', '[{"min":10,"preco":9.90},{"min":20,"preco":7.90}]'),
  ('porta-retrato-coracao-de-trico', '[{"min":10,"preco":5.90},{"min":20,"preco":4.90}]'),
  ('chaveiro-abridor-de-lata-esmalte', '[{"min":10,"preco":6.90},{"min":20,"preco":5.90}]'),
  ('chaveiro-porta-escovinha-de-cilios', '[{"min":10,"preco":9.90},{"min":20,"preco":7.90}]'),
  ('porta-joias-com-bandeja-de-brincos', '[{"min":10,"preco":30.90},{"min":20,"preco":24.90}]'),
  ('bandeja-porta-joias-bolhas', '[{"min":10,"preco":12.90},{"min":20,"preco":9.90}]'),
  ('chaveiro-porta-creme', '[{"min":10,"preco":10.90},{"min":20,"preco":7.90}]'),
  ('chaveiro-abridor-de-lata-beijo', '[{"min":10,"preco":7.90},{"min":20,"preco":5.90}]'),
  ('chaveiro-abridor-de-lata-coracao', '[{"min":10,"preco":7.90},{"min":20,"preco":5.90}]'),
  ('suporte-de-celular-chaveiro', '[{"min":10,"preco":8.90},{"min":20,"preco":7.90}]'),
  ('suporte-de-celular-minimalista', '[{"min":10,"preco":14.90},{"min":20,"preco":11.90}]'),
  ('pote-com-tampa-de-rosca', '[{"min":10,"preco":11.90},{"min":20,"preco":8.90}]'),
  ('chaveiro-porta-anel-floral', '[{"min":10,"preco":7.90},{"min":20,"preco":6.90}]'),
  ('chaveiro-caixinha-com-tampa', '[{"min":10,"preco":8.90},{"min":20,"preco":6.90}]'),
  ('caixinha-coracao-de-trico-com-flor', '[{"min":10,"preco":12.90},{"min":20,"preco":9.90}]'),
  ('chaveiro-mini-camera-com-foto', '[{"min":10,"preco":15.90},{"min":20,"preco":11.90}]'),
  ('chaveiro-coracao-giroscopio-fidget', '[{"min":10,"preco":8.90},{"min":20,"preco":6.90}]')
) as v(slug, faixas)
where p.slug = v.slug;
