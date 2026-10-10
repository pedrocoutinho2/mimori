# Site Mimori · mimori3d.com.br

Catálogo da Mimori com pedido pelo WhatsApp e painel admin. HTML de arquivo único, Supabase e GitHub Pages, sem build.

## O que tem aqui

| Caminho | O que é |
|---|---|
| `index.html` | O site inteiro (home, catálogo, categorias, produto, presentes, personalizados, para empresas, busca e lista) |
| `404.html` | Cópia do `index.html`, gerada pelo script. Abre endereços que ainda não têm página fixa |
| pastas de categoria e produto | Páginas fixas geradas pelo script, uma por endereço, para o Google indexar |
| `sitemap.xml` e `robots.txt` | Gerados pelo script. O painel `/admin` fica fora do Google |
| `admin/index.html` | Painel: produtos com custo e lucro, fotos e vídeo, promoções, relatórios, usuários e troca de senha |
| `data/catalogo.json` | Reserva: o site só usa se o Supabase não responder. A vitrine e a configuração passaram para o banco no SQL 015 |
| `assets/` | Logo, fotos e vídeos das peças |
| `ferramentas/gerar-paginas.py` | Gera as páginas fixas, o sitemap, o robots e o 404 |
| `sql/` | Banco, na ordem em que foi aplicado. O 004 é só alternativa à importação e não deve ser rodado |
| `.github/workflows/paginas-fixas.yml` | Refaz as páginas fixas a partir do Supabase a cada 6 horas (ou pelo botão Run workflow na aba Actions) |
| `supabase/functions/painel-usuarios` | Função que convida e remove usuários do painel |
| `gamer/` | Catálogo gamer original. Não mexer |

## No ar

- Site: https://mimori3d.com.br (GitHub Pages, domínio pela Hostinger, HTTPS ativo).
- Supabase: projeto `ydnanmpqwbjzskovnhyh`. SQL 001, 002, 003, 005, 006, 007, 008, 009, 010, 011, 012, 014, 015 e 016 aplicados (013 pendente de confirmação). Preço por quantidade (`faixas`, `faixa_consulta`) desde 10/10/2026, editável no painel; brindes para salão em dois blocos pelo campo `grupos` (`lembrancinha` e `presente`). Categoria Brindes para salão desde 09/10/2026 (26 produtos; licença comercial dos modelos do 011 a cargo do Pedro). Catálogo importado em 03/10/2026. Kits e opções com preço (tabela `produto_opcoes`) desde 04/10/2026, editáveis no painel.
- Painel: https://mimori3d.com.br/admin (Pedro e Kamilla como administradores).

## Dia a dia

- Produto, preço, foto, promoção, usuário, prateleiras da home e datas especiais: tudo pelo painel em `/admin` (aba Vitrine para as duas últimas). Grava no Supabase e o site mostra na hora.
- O painel salva o produto inteiro numa transação só (dados, cores, kits e custo) e recusa salvar por cima se outra pessoa alterou a mesma peça depois que você abriu.
- As páginas fixas que o Google lê se refazem sozinhas a cada 6 horas pelo GitHub Actions. Antes de subir mudança pelo GitHub Desktop, clique em Fetch/Pull: o robô pode ter salvo páginas novas.
- Mudou o `index.html`? No Terminal, dentro desta pasta, rode (o robô também faz isso, mas só a cada 6 horas):
  `python3 ferramentas/gerar-paginas.py`
  Ele refaz as páginas fixas de cada categoria e produto, o `sitemap.xml`, o `robots.txt` e o `404.html`. Depois, commit e push no GitHub Desktop.

## Pendências

- `[DECIDIR]` data-limite de pedidos de Halloween e Natal (a frase saiu das faixas em 04/10/2026). O texto da data especial de Natal ainda tem `[data-limite]` e entra no ar em 01/11: corrigir pela aba Vitrine.
- `[APLICAR]` `sql/017_vitrine_no_banco_e_salvar_produto.sql` no SQL Editor. Sem ele, a aba Vitrine fica bloqueada e o site usa a vitrine do arquivo.
- `[CONFIRMAR]` taxa do link de pagamento e valor da hora de mão de obra (`parametros_custo`).
- `[CONFIRMAR]` CNPJ no rodapé, aviso de cookies e licença de uso de cada modelo e foto do criador.
- Fotos do criador e da exceção da §11: trocar pela foto da peça real pelo painel, conforme imprimir.
