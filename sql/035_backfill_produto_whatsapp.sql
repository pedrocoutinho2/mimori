-- 14/10/2026 · Cliques no WhatsApp antigos sem produto: preenche produto_id pela página de produto
-- (/categoria/slug). Aplicado direto no Supabase.
update eventos e set produto_id = p.id
from produtos p
where e.tipo = 'whatsapp_clique' and e.produto_id is null
  and p.slug = split_part(rtrim(e.pagina, '/'), '/', 3);
