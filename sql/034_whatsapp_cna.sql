-- 034 · 14/10/2026 · WhatsApp do Pedro nos pedidos da página /cna
-- A página /cna, as peças do CNA e o pedido (lista) que tiver peça do CNA abrem o WhatsApp do Pedro.
-- O resto do site segue no WhatsApp da Mimori (chave 'whatsapp', da Kamilla). Rodapé e menu não mudam.
-- Para trocar o número depois, muda só esta chave no banco.
insert into public.site_config (chave, valor) values ('whatsappCna', '5521995215332')
on conflict (chave) do update set valor = excluded.valor;

select chave, valor from public.site_config where chave in ('whatsapp', 'whatsappCna');
