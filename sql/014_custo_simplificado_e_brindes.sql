-- 014 · Custo simplificado no painel: mão de obra por produto (opcional), hora de máquina e mão de obra alinhadas ao vault, custo de partida dos 26 brindes para salão
-- APLICADO em 09/10/2026 no projeto ydnanmpqwbjzskovnhyh (migração 014_custo_simplificado_e_brindes), a pedido do Pedro.
-- hora_maquina 0,67 -> 1,18 (A1: energia 0,13 + depreciação 0,90 + manutenção 0,15, _parametros-preco.json de 05/10/2026); mao_obra_hora 0 -> 20.
-- A mão de obra deixa de ser global (15 min em todo produto) e passa a ser por produto, só quando preenchida.
-- Brindes: peso e tempo da versão mais barata, perfil do criador no MakerWorld (suposição); argola R$ 0,40 nos chaveiros.
alter table public.produto_custos add column if not exists mao_obra_min int;
update public.parametros_custo set hora_maquina = 1.18, mao_obra_hora = 20 where id = 1;
create or replace view public.produto_lucro with (security_invoker = true) as
select p.id, p.nome, p.preco,
  round(c.gramas * pc.pla_kg / 1000, 2) as material,
  round(c.horas * pc.hora_maquina, 2) as maquina,
  round((c.gramas * pc.pla_kg / 1000 + c.horas * pc.hora_maquina) * pc.refugo, 2) as refugo,
  pc.embalagem, c.insumos,
  round(coalesce(c.mao_obra_min, 0) / 60.0 * pc.mao_obra_hora, 2) as mao_obra,
  round((c.gramas * pc.pla_kg / 1000 + c.horas * pc.hora_maquina) * (1 + pc.refugo) + pc.embalagem + c.insumos + coalesce(c.mao_obra_min, 0) / 60.0 * pc.mao_obra_hora, 2) as custo_total,
  c.horas, c.fonte
from public.produtos p
join public.produto_custos c on c.produto_id = p.id
cross join public.parametros_custo pc;
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
select p.id, v.g, v.h, v.ins, 'suposição' from (values
('porta-batom-florzinha', 14, 0.96, 0.40), ('porta-retrato-coracao-de-trico', 5, 0.58, 0.00), ('chaveiro-abridor-de-lata-esmalte', 7, 0.39, 0.40),
('chaveiro-porta-escovinha-de-cilios', 14, 1.16, 0.40), ('porta-joias-com-bandeja-de-brincos', 104, 2.45, 0.00), ('bandeja-porta-treco-bolhas', 31, 1.12, 0.00),
('chaveiro-porta-treco-de-bolsa', 18, 0.99, 0.40), ('chaveiro-abridor-de-lata-beijo', 6, 0.66, 0.40), ('chaveiro-abridor-de-lata-coracao', 9, 0.45, 0.40),
('suporte-de-celular-chaveiro', 17, 0.62, 0.40), ('suporte-de-celular-minimalista', 41, 1.11, 0.00), ('pote-com-tampa-de-rosca', 24, 1.2, 0.00),
('chaveiro-porta-anel-floral', 10, 0.66, 0.40), ('chaveiro-caixinha-com-tampa', 13, 0.76, 0.40), ('chaveiro-porta-joias-redondo', 11, 0.67, 0.40),
('caixinha-coracao-de-trico-com-flor', 23, 2.21, 0.00), ('chaveiro-mini-camera-com-foto', 31, 2.3, 0.40), ('porta-anel-dinossauro', 13, 1.14, 0.00),
('chaveiro-porta-treco-com-tampa', 19, 1.54, 0.40), ('suporte-de-celular', 38, 1.19, 0.00), ('porta-joias-de-viagem', 83, 2.84, 0.00),
('chaveiro-caixinha-coracao', 16, 0.83, 0.40), ('chaveiro-abridor-de-lata-redondo', 6, 0.56, 0.40), ('chaveiro-coracao-giroscopio-fidget', 15, 0.4, 0.40),
('chaveiro-rosa', 18, 2.16, 0.40), ('mini-caixa-de-presente', 19, 0.67, 0.00)
) as v(slug, g, h, ins) join public.produtos p on p.slug = v.slug
on conflict (produto_id) do nothing;
