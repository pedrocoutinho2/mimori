-- Mimori · Suporte de Celular Chaveiro (MIM-SCCH01) · 10/10/2026
-- Versão única: padrão com logo personalizada e tag NFC, R$ 19,90
-- Atacado: 10+ R$ 10,90 · 20+ R$ 9,90 · 50+ a consultar
begin;

delete from produto_opcoes
where produto_id = 'dcd57a54-0356-4e38-87ed-06647d10492a';

update produtos set
  preco = 19.90,
  a_partir = false,
  selo = 'Com tag NFC',
  faixas = '[{"min":10,"preco":10.9},{"min":20,"preco":9.9}]'::jsonb,
  faixa_consulta = 50,
  descricao = $d$📱 Fechado, é um chaveiro reto que cabe no bolso. Aberto, segura o celular em pé na mesa, na horizontal ou na vertical. Abre com um movimento e trava quando fecha.

💜 COM A LOGO DO SEU SALÃO E TAG NFC
A plaquinha leva a logo do seu salão. Junto vai uma tag NFC: a cliente encosta o celular e já abre o Instagram, o WhatsApp ou o link de agendamento do salão, sem baixar nada.
A gente confirma a arte e o link com você no WhatsApp antes de produzir.

📦 O QUE VEM NO PEDIDO
1 suporte chaveiro com a logo do salão, na cor escolhida
1 tag NFC com o link que você escolher
1 corrente com argola de chaveiro
O celular das fotos não acompanha o produto

📏 FICHA TÉCNICA
Material: PLA, impresso já articulado, sem montagem
Para celular com capinha de até 11,5 mm
Cores: Rosa bebê, Roxo ametista, Azul bebê, Branco, Preto ou Cinza claro

💅 PARA O SEU SALÃO
Para dar às clientes em data especial, aniversário ou fidelidade. A partir de 10 peças o preço baixa, e acima de 50 a gente combina com você no WhatsApp.

⏱️ PRAZO
Produzido em 3 a 5 dias úteis depois do pagamento.

🧼 CUIDADOS
Limpar com pano seco.
Não deixar ao sol direto ou dentro do carro. O PLA pode deformar em temperatura alta.
Não é brinquedo. Não indicado para menores de 3 anos, porque tem peças pequenas.$d$,
  atualizado_em = now()
where id = 'dcd57a54-0356-4e38-87ed-06647d10492a';

commit;

-- conferência (aplicado em 10/10/2026 pelo Claude no SQL Editor via MCP; retorno: 19.90, a_partir false, 0 opções)
select preco, a_partir, selo, faixas, faixa_consulta,
  (select count(*) from produto_opcoes where produto_id = 'dcd57a54-0356-4e38-87ed-06647d10492a') as opcoes
from produtos where id = 'dcd57a54-0356-4e38-87ed-06647d10492a';
