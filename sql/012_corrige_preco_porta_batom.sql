-- 012 · Porta Batom Florzinha: preço refeito com a argola de R$ 0,40, que tinha ficado fora do custo no 010
-- APLICADO em 09/10/2026 no projeto ydnanmpqwbjzskovnhyh (migração 012_corrige_preco_porta_batom).
-- Batom ou balm 14,90 -> 15,90; Balm em bastão fino 13,90 -> 14,90. Planilha: mimori-brindes-salao-custos.xlsx
update produto_opcoes o set preco = 15.90 from produtos p where o.produto_id = p.id and p.slug = 'porta-batom-florzinha' and o.nome = 'Batom ou balm';
update produto_opcoes o set preco = 14.90 from produtos p where o.produto_id = p.id and p.slug = 'porta-batom-florzinha' and o.nome = 'Balm em bastão fino';
update produtos set preco = 14.90 where slug = 'porta-batom-florzinha';
