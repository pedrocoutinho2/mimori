-- 040 · Suporte de Celular Chaveiro (MIM-SCCH01) com e sem tag NFC (17/10/2026)
-- Pedido do Pedro: versão com NFC e sem NFC como variação, com preços diferentes.
-- Sem NFC: R$ 16,90 (preço da antiga opção "Com plaquinha para logo", sql/011); faixas 10+ R$ 8,90 e 20+ R$ 7,90 (faixas da opção comum, sql/015).
-- Com NFC: R$ 19,90 (sql/018). O site calcula a faixa da opção em proporção ao preço base e arredonda para ,90:
--   19,90 × 8,90 / 16,90 = 10,48 → 10,90 · 19,90 × 7,90 / 16,90 = 9,30 → 9,90 (iguais às faixas atuais do NFC). 50+ segue a consultar.
-- Não apaga dado: o produto estava sem opções desde o 018.
begin;

insert into produto_opcoes (produto_id, nome, preco, ordem)
select 'dcd57a54-0356-4e38-87ed-06647d10492a', v.nome, v.preco, v.ordem
from (values ('Com tag NFC', 19.90, 0), ('Sem tag NFC', 16.90, 1)) as v(nome, preco, ordem)
where not exists (select 1 from produto_opcoes where produto_id = 'dcd57a54-0356-4e38-87ed-06647d10492a');

update produtos set
  preco = 16.90,
  a_partir = true,
  selo = 'Com ou sem NFC',
  faixas = '[{"min":10,"preco":8.9},{"min":20,"preco":7.9}]'::jsonb,
  faixa_consulta = 50,
  descricao = $d$📱 Fechado, é um chaveiro reto que cabe no bolso. Aberto, segura o celular em pé na mesa, na horizontal ou na vertical. Abre com um movimento e trava quando fecha.

💜 COM A LOGO DO SEU SALÃO
A plaquinha leva a logo do seu salão. A gente confirma a arte com você no WhatsApp antes de produzir.

📲 COM OU SEM TAG NFC
Na versão com NFC, vai junto uma tag: a cliente encosta o celular e já abre o Instagram, o WhatsApp ou o link de agendamento do salão, sem baixar nada. O link a gente também confirma com você antes.

📦 O QUE VEM NO PEDIDO
1 suporte chaveiro com a logo do salão, na cor escolhida
1 corrente com argola de chaveiro
Na versão com NFC, 1 tag NFC com o link que você escolher
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

-- conferência
select p.preco, p.a_partir, p.selo, p.faixas, p.faixa_consulta,
  (select json_agg(json_build_object('nome', o.nome, 'preco', o.preco) order by o.ordem) from produto_opcoes o where o.produto_id = p.id) as opcoes
from produtos p where p.id = 'dcd57a54-0356-4e38-87ed-06647d10492a';
