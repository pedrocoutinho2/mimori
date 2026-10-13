-- 028 · Microfone CNA sem o selo "Canopla CNA" (13/10/2026)
-- Pedido do Pedro na página /cna. Só limpa o selo; o resto do produto não muda.
update public.produtos set selo = null where slug = 'microfone-cna';
