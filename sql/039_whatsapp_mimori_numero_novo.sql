-- 039 · WhatsApp da Mimori passa a ser o número próprio da marca
-- Data: 16/10/2026 · Decisão: 50-decisoes/2026-10-15-mimori-whatsapp-numero-novo.md
-- Troca o (21) 99623-7746 (Kamilla) pelo (21) 97507-5316 (chip da Mimori) em todo o site.
-- Não mexe em whatsappCna: a página /cna e as peças do CNA continuam no WhatsApp do Pedro.
-- Status: [PENDENTE] aplicar no SQL Editor do projeto ydnanmpqwbjzskovnhyh.

insert into public.site_config (chave, valor) values ('whatsapp', '5521975075316')
  on conflict (chave) do update set valor = excluded.valor;
insert into public.site_config (chave, valor) values ('whatsappTxt', '(21) 97507-5316')
  on conflict (chave) do update set valor = excluded.valor;

-- Conferência: deve voltar 5521975075316 e (21) 97507-5316
select chave, valor from public.site_config where chave in ('whatsapp', 'whatsappTxt', 'whatsappCna');
