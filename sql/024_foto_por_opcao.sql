-- 024 · Foto por opção (thumb do modelo) e fim do cache das fotos CNA (12/10/2026)
-- APLICADO em 12/10/2026 pelo Claude via MCP (migração 024_foto_por_opcao), a pedido do Pedro.
-- Por quê: na página do produto, as opções de mesmo preço passam a mostrar só o nome e uma miniatura do modelo,
-- e escolher a opção leva a galeria para a foto dela. A coluna nova é editável no painel (Kits e opções).
-- As fotos CNA foram regravadas com o mesmo nome; o sufixo ?v=20261012b força o navegador a buscar a versão nova.
-- Não apaga dado: acrescenta coluna e atualiza caminhos. A função salvar_produto nova ficou no 025.
alter table public.produto_opcoes add column if not exists foto text;


update public.produto_fotos f set caminho = f.caminho || '?v=20261012b' from public.produtos p
  where f.produto_id = p.id and p.slug in ('chaveiro-giratorio-cna','chaveiro-monstrinho-cna','microfone-cna') and f.caminho not like '%?v=%';
update public.produto_opcoes o set foto = v.foto from public.produtos p, (values ('Ben','assets/fotos/chaveiro-giratorio-cna-1.jpg?v=20261012b'),('Dani','assets/fotos/chaveiro-giratorio-dani-sim.jpg?v=20261012b'),('Iza','assets/fotos/chaveiro-giratorio-iza-sim.jpg?v=20261012b'),('Ju','assets/fotos/chaveiro-giratorio-ju-sim.jpg?v=20261012b'),('Leo','assets/fotos/chaveiro-giratorio-leo-sim.jpg?v=20261012b'),('Sol','assets/fotos/chaveiro-giratorio-sol-sim.jpg?v=20261012b'),('Thiago','assets/fotos/chaveiro-giratorio-thiago-sim.jpg?v=20261012b')) v(nome, foto)
  where o.produto_id = p.id and p.slug = 'chaveiro-giratorio-cna' and o.nome = v.nome;
update public.produto_opcoes o set foto = v.foto from public.produtos p, (values ('Dani','assets/fotos/chaveiro-monstrinho-cna-1.jpg?v=20261012b'),('Iza','assets/fotos/chaveiro-monstrinho-iza-sim.jpg?v=20261012b'),('Ju','assets/fotos/chaveiro-monstrinho-ju-sim.jpg?v=20261012b'),('Leo','assets/fotos/chaveiro-monstrinho-leo-sim.jpg?v=20261012b'),('Sol','assets/fotos/chaveiro-monstrinho-sol-sim.jpg?v=20261012b'),('Thiago','assets/fotos/chaveiro-monstrinho-thiago-sim.jpg?v=20261012b'),('Ben','assets/fotos/chaveiro-monstrinho-ben-sim.jpg?v=20261012b')) v(nome, foto)
  where o.produto_id = p.id and p.slug = 'chaveiro-monstrinho-cna' and o.nome = v.nome;

-- vídeo do microfone (enviado pelo Pedro em 12/10, 16 s, resolução original 464 x 832)
insert into public.produto_videos (produto_id, caminho, ordem)
  select p.id, 'assets/videos/microfone-cna.mp4', 0 from public.produtos p
  where p.slug = 'microfone-cna' and not exists (select 1 from public.produto_videos x where x.produto_id = p.id);
