-- 019 · Categoria oculta (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 019_categoria_oculta), a pedido do Pedro.
--
-- Por quê: a página /cna mostra produtos feitos para unidades do CNA, que não entram no catálogo da Mimori.
-- Categoria com oculta = true fica fora do menu, da home, do catálogo, da busca e do sitemap,
-- e sai com noindex. Abre só pelo endereço direto (mimori3d.com.br/cna).
-- Só acrescenta uma coluna com valor padrão false. O site que já está no ar ignora a coluna.
alter table public.categorias add column if not exists oculta boolean not null default false;
comment on column public.categorias.oculta is 'Fora do menu, da home, do catálogo, da busca e do Google. Abre só pelo endereço direto (ex.: /cna).';
