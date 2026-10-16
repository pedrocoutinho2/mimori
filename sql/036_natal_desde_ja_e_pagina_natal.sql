-- 036 · Data especial de Natal no ar desde 15/10/2026 e link para a página /natal
-- APLICADO em 15/10/2026 no projeto ydnanmpqwbjzskovnhyh, pelo painel logado do Pedro (cliente Supabase do /admin), a pedido do Pedro.
-- Contexto: o Pedro quer os produtos de Natal aparecendo desde já e uma página /natal de acesso direto.
-- A página /natal é a rota nova paginaTema() no index.html (qualquer data especial publicada abre em /{slug}).
-- O Contador de Natal (MIM-NATC01) foi incluído na data pela aba Vitrine do painel no mesmo dia.
update colecoes
   set inicio = '2026-10-15',
       link   = 'natal'
 where slug = 'natal' and tipo = 'data';
