-- 025 · salvar_produto passa a gravar a foto da opção (12/10/2026)
-- APLICADO em 12/10/2026 às 21h06 pelo Pedro no SQL Editor (conferido pelo Claude: a função grava a foto da opção).
-- Sem ele, salvar no painel um produto com opções apaga a foto de cada opção (a miniatura some do site).
-- É a mesma função do 017, com a coluna foto no insert de produto_opcoes. Depende do 024 (coluna produto_opcoes.foto).
create or replace function public.salvar_produto(p jsonb, p_versao timestamptz default null)
returns table (id uuid, atualizado_em timestamptz)
language plpgsql security invoker set search_path = public as $$
declare
  v_id uuid := nullif(p->>'id', '')::uuid;
  v_atual timestamptz;
begin
  if not public.e_do_painel() then raise exception 'sem acesso ao painel'; end if;
  if v_id is not null then
    select pr.atualizado_em into v_atual from public.produtos pr where pr.id = v_id for update;
    if not found then raise exception 'produto não encontrado'; end if;
    if p_versao is not null and v_atual is distinct from p_versao then
      raise exception 'conflito: este produto foi alterado por outra pessoa depois que você abriu. Feche, abra de novo e refaça a alteração.';
    end if;
    update public.produtos set
      nome = p->>'nome', slug = p->>'slug', sku = nullif(p->>'sku', ''), categoria_id = (p->>'categoria_id')::uuid,
      preco = (p->>'preco')::numeric, selo = nullif(p->>'selo', ''), descricao = coalesce(p->>'descricao', ''),
      publicado = coalesce((p->>'publicado')::boolean, false), a_partir = coalesce((p->>'a_partir')::boolean, false),
      tags = coalesce(array(select jsonb_array_elements_text(p->'tags')), '{}'),
      faixas = case when p ? 'faixas' then coalesce(p->'faixas', '[]'::jsonb) else faixas end,
      faixa_consulta = case when p ? 'faixa_consulta' then nullif(p->>'faixa_consulta', '')::int else faixa_consulta end
    where produtos.id = v_id;
  else
    insert into public.produtos (nome, slug, sku, categoria_id, preco, selo, descricao, publicado, a_partir, tags, faixas, faixa_consulta)
    values (p->>'nome', p->>'slug', nullif(p->>'sku', ''), (p->>'categoria_id')::uuid, (p->>'preco')::numeric, nullif(p->>'selo', ''),
      coalesce(p->>'descricao', ''), coalesce((p->>'publicado')::boolean, false), coalesce((p->>'a_partir')::boolean, false),
      coalesce(array(select jsonb_array_elements_text(p->'tags')), '{}'), coalesce(p->'faixas', '[]'::jsonb), nullif(p->>'faixa_consulta', '')::int)
    returning produtos.id into v_id;
  end if;

  delete from public.variacoes where produto_id = v_id;
  insert into public.variacoes (produto_id, cor, ordem)
    select v_id, x.cor, x.o - 1 from jsonb_array_elements_text(coalesce(p->'cores', '[]')) with ordinality x(cor, o);

  delete from public.produto_opcoes where produto_id = v_id;
  insert into public.produto_opcoes (produto_id, nome, preco, ordem, foto)
    select v_id, x.e->>'nome', (x.e->>'preco')::numeric, x.o - 1, nullif(x.e->>'foto', '') from jsonb_array_elements(coalesce(p->'opcoes', '[]')) with ordinality x(e, o);

  if p ? 'custo' then
    insert into public.produto_custos (produto_id, gramas, horas, insumos, mao_obra_min, fonte, atualizado_em)
    values (v_id, (p->'custo'->>'gramas')::numeric, (p->'custo'->>'horas')::numeric, coalesce((p->'custo'->>'insumos')::numeric, 0),
      (p->'custo'->>'mao_obra_min')::int, p->'custo'->>'fonte', now())
    on conflict (produto_id) do update set gramas = excluded.gramas, horas = excluded.horas, insumos = excluded.insumos,
      mao_obra_min = excluded.mao_obra_min, fonte = excluded.fonte, atualizado_em = now();
  end if;

  return query select pr.id, pr.atualizado_em from public.produtos pr where pr.id = v_id;
end $$;
grant execute on function public.salvar_produto(jsonb, timestamptz) to authenticated;
