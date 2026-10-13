-- 029 · Microfone CNA só por unidade (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 029_microfone_cna_so_unidade).
-- Decisão do Pedro: o microfone não é pedido em quantidade. Sai a caixa "Preço por quantidade"
-- e o texto de lote; preço de R$ 29,90 mantido (decisão de 29/09/2026). Só update.
begin;

update public.produtos set faixas = '[]'::jsonb, faixa_consulta = null, atualizado_em = now(),
  descricao = replace(replace(descricao,
    'Pra equipe usar nos vídeos da unidade ou pra presentear em evento. Acima de 50 unidades a gente combina o valor com você no WhatsApp.',
    'Pra equipe usar nos vídeos da unidade ou pra presentear em evento.'),
    'Pedido pequeno: de 3 a 5 dias úteis depois do pagamento.
Lote: o prazo a gente combina com você pela quantidade.',
    'De 3 a 5 dias úteis depois do pagamento.')
  where slug = 'microfone-cna';

commit;
