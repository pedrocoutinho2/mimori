-- 032_cliques_em_botoes.sql
-- Registra todo clique em botão e link do site (tipo 'clique'), para o relatório "Cliques por botão" do painel.
-- As conversões continuam nos tipos que já existiam: 'lista_adicionou' (colocou no carrinho) e
-- 'whatsapp_clique' (foi para o WhatsApp). No Google Analytics elas viram add_to_cart e clique_whatsapp;
-- no Meta Pixel, AddToCart e Contact.
-- Sem dado pessoal: 'botao' guarda só o rótulo do botão (ex.: "Adicionar ao pedido (produto)").
-- Não apaga nada: só amplia a lista de tipos aceitos e limita o tamanho do rótulo.

alter table public.eventos drop constraint if exists eventos_tipo_check;
alter table public.eventos add constraint eventos_tipo_check
  check (tipo in ('visita', 'produto_visto', 'lista_adicionou', 'lista_enviou', 'whatsapp_clique', 'busca', 'clique'));

drop policy if exists "site registra eventos" on public.eventos;
create policy "site registra eventos" on public.eventos for insert to anon, authenticated
  with check (char_length(coalesce(termo, '')) <= 80
          and char_length(coalesce(pagina, '')) <= 200
          and char_length(coalesce(botao, '')) <= 80);

create index if not exists eventos_tipo_botao_idx on public.eventos (tipo, botao);
