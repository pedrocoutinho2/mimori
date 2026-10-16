-- 037 · Preço do Gato Derrubando Vaso (16/10/2026)
-- PENDENTE: aplicar no SQL Editor do Supabase (projeto ydnanmpqwbjzskovnhyh). O MCP não teve permissão de escrita nesta sessão.
-- Só update e upsert de custo; não apaga nada.
--
-- Decisão do Pedro (16/10/2026): preço da engine 2x, R$ 29,90 (era R$ 15,90).
-- Custo pelo print do fatiador enviado na conversa: 72,10 g (54,81 g de peça + 17,29 g de purga), 2h35, 35 trocas de filamento.
--   Custo de produção com MO: R$ 14,47 · sem MO: R$ 11,07 · venda direta, sem taxa de pagamento [CONFIRMAR].
--   Lucro R$ 15,43 · R$ 5,97 por hora de máquina (abaixo do piso de R$ 15/h, acima do de R$ 5/h).
-- [CONFIRMAR] O print não bate com a versão de 5 cm (MakerWorld: 25 min). A ficha técnica do site (5 × 4 × 5 cm, 11 g) não foi alterada.
-- Licença do modelo: MakerWorld Exclusive License, que proíbe uso comercial. Mantido no site por decisão do Pedro.
begin;

update public.produtos set preco = 29.90, atualizado_em = now()
  where slug = 'gato-derrubando-vaso';

-- opções (cores) com o mesmo preço do produto
update public.produto_opcoes o set preco = p.preco from public.produtos p
  where o.produto_id = p.id and p.slug = 'gato-derrubando-vaso';

-- custo no painel (fatiador)
insert into public.produto_custos (produto_id, gramas, horas, insumos, fonte)
  select id, 72.10, 2.583, 0, 'fatiador' from public.produtos where slug = 'gato-derrubando-vaso'
  on conflict (produto_id) do update set gramas = excluded.gramas, horas = excluded.horas, insumos = excluded.insumos, fonte = excluded.fonte;

commit;

-- conferência
select p.slug, p.preco, (select json_agg(o.preco) from public.produto_opcoes o where o.produto_id = p.id) opcoes
  from public.produtos p where p.slug = 'gato-derrubando-vaso';
