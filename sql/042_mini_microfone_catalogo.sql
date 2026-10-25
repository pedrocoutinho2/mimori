-- 25/10/2026 · Mini Microfone Personalizado no catálogo geral (pedido do Pedro)
-- Produto novo MIM-MICR01, sem "CNA" no nome, R$ 39,90, sem opções.
-- Cor da canopla e logo vêm pelo WhatsApp depois do pedido.
-- Fotos e vídeo: os mesmos do Microfone CNA por decisão do Pedro, até ele subir fotos novas.
-- Aplicado pelo conector em 25/10, menos o DELETE das opções (pedia confirmação): rodar o bloco final.

-- produto, custo, fotos e vídeo já criados pelo conector (ver produtos.sku = 'MIM-MICR01')

delete from produto_opcoes
where produto_id = (select id from produtos where sku = 'MIM-MICR01')
  and nome in ('Com nome', 'Lisa');
