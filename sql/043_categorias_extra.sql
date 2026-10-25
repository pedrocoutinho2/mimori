-- 25/10/2026 · Produto em mais de uma categoria (pedido do Pedro)
-- categoria_id segue como a principal (define o endereço da página).
-- categorias_extra guarda os slugs das outras categorias em que o produto também aparece.
-- Aplicado pelo conector em 25/10/2026.
alter table public.produtos add column if not exists categorias_extra text[] not null default '{}';
comment on column public.produtos.categorias_extra is 'Outras categorias (slug) em que o produto também aparece. A categoria_id segue como a principal, que define o endereço da página.';

-- Suporte de Celular Chaveiro: principal Brindes para salão, também em Personalizados
update public.produtos set categorias_extra = array['personalizados'] where slug = 'suporte-de-celular-chaveiro';

-- O painel grava categorias_extra com um update direto depois do salvar_produto.
