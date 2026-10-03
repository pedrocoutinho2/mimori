-- 006_corrige_preco_vigente.sql
-- Corrige a visão de preço do dia: sem promoção ativa, ela devolvia R$ 0,90 (o greatest ignorava o nulo).
-- Aplicado pelo Claude no Supabase em 03/10/2026.

create or replace view public.produtos_preco_vigente with (security_invoker = true) as
select p.id, p.preco as preco_cheio,
  coalesce(min(greatest(0.90, floor(
    case when pr.tipo = 'percentual' then p.preco * (1 - pr.valor / 100) else p.preco - pr.valor end - 0.90) + 0.90)) filter (where pr.id is not null), p.preco) as preco_vigente,
  (array_agg(pr.nome order by case when pr.tipo = 'percentual' then p.preco * (1 - pr.valor / 100) else p.preco - pr.valor end) filter (where pr.id is not null))[1] as promocao
from public.produtos p
left join public.promocoes pr on not pr.pausada and current_date between pr.inicio and pr.fim
  and ((pr.alvo_tipo = 'produto' and pr.alvo_produto = p.id)
    or (pr.alvo_tipo = 'categoria' and pr.alvo_categoria = p.categoria_id)
    or (pr.alvo_tipo = 'tag' and pr.alvo_tag = any (p.tags)))
group by p.id, p.preco;
