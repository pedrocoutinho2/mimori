-- 023 · Microfone CNA: foto real (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 023_microfone_cna_foto), depois do push da foto. Não apaga nada.
-- Foto enviada pelo Pedro no chat em 12/10, corte 1:1 com a cabeça e a canopla no centro. Vídeo ainda não enviado.
insert into public.produto_fotos (produto_id, caminho, tipo, ordem)
  select p.id, 'assets/fotos/microfone-cna-1.jpg', 'real', 0 from public.produtos p
  where p.slug = 'microfone-cna' and not exists (select 1 from public.produto_fotos x where x.produto_id = p.id);
