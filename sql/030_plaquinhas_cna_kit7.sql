-- 030 · Plaquinhas de Pintar Monstrinhos CNA passam a ser kit com as 7 plaquinhas
-- 13/10/2026 · decisão do Pedro
--  * Kit com os 7 monstrinhos, de 8 a 12 cm cada, impresso em 1 placa
--    (fatiador: 42,86 g, 1h55, 3 trocas de filamento)
--  * Custo por kit: R$ 6,87 de produção sem MO, R$ 8,27 com MO, embalagem R$ 0,40 por kit
--  * Preço: 1 a 9 R$ 19,90 · 10 a 49 R$ 14,90 · 50 a 99 R$ 11,90 · 100+ a consultar
--    (10 a 49 e 50 a 99 abaixo do piso de R$ 5/h, aceito pelo Pedro "por enquanto")
--  * Foto nova: assets/fotos/plaquinhas-monstrinhos-cna-kit7.jpg (montagem a partir do fatiador)
-- Só update e insert; não apaga nada.
begin;

update public.produtos set
  preco = 19.90,
  a_partir = false,
  faixas = '[{"min":10,"preco":14.9},{"min":50,"preco":11.9}]'::jsonb,
  faixa_consulta = 100,
  atualizado_em = now(),
  descricao = $d$🎨 A turma inteira de monstrinhos do CNA em plaquinhas prontas pra pintar. São 7 plaquinhas por kit, com o contorno preto em relevo sobre a base branca. A criança colore cada pedacinho e leva pra casa os monstrinhos do jeito dela.

O contorno em relevo ajuda a pintar sem sair da linha.

📦 O QUE VEM NO PEDIDO
1 kit com 7 plaquinhas, uma de cada monstrinho do CNA
As canetinhas não acompanham. Se quiser o kit com canetinhas, a gente combina no WhatsApp

📏 FICHA TÉCNICA
Material: PLA
Base branca com contorno preto em relevo
Quantidade: 7 plaquinhas por kit
Tamanho: de 8 a 12 cm de altura, conforme o monstrinho
Peso: aproximadamente 43 g por kit

🏫 PARA A SUA UNIDADE
Atividade pro Dia das Crianças, aula especial, colônia de férias ou evento com as famílias. A partir de 10 kits o preço baixa, e acima de 100 a gente combina com você no WhatsApp.

⏱️ PRAZO
Pedido pequeno: de 3 a 5 dias úteis depois do pagamento.
Lote: o prazo a gente combina com você pela quantidade.

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Pintura com acompanhamento de um adulto. Não indicado para menores de 3 anos.$d$
where slug = 'plaquinhas-de-pintar-monstrinhos-cna';

insert into public.produto_fotos (produto_id, caminho, tipo, ordem)
select id, 'assets/fotos/plaquinhas-monstrinhos-cna-kit7.jpg?v=20261013a', 'excecao', 0
from public.produtos p
where slug = 'plaquinhas-de-pintar-monstrinhos-cna'
  and not exists (select 1 from public.produto_fotos f where f.produto_id = p.id and f.caminho like 'assets/fotos/plaquinhas-monstrinhos-cna-kit7.jpg%');

update public.produto_custos set
  gramas = 42.86, horas = 1.92, insumos = 0, mao_obra_min = 4, fonte = 'fatiador', atualizado_em = now()
where produto_id = (select id from public.produtos where slug = 'plaquinhas-de-pintar-monstrinhos-cna');

commit;
