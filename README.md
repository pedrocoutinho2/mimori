# Site Mimori · mimori3d.com.br

Catálogo da Mimori com pedido pelo WhatsApp e painel admin. HTML de arquivo único, Supabase e GitHub Pages, sem build.

## O que tem aqui

| Caminho | O que é |
|---|---|
| `index.html` | O site inteiro (home, catálogo, categorias, produto, presentes, personalizados, para empresas, busca e lista) |
| `404.html` | Cópia do `index.html`. O GitHub Pages usa para abrir os endereços amigáveis (`/produtos-religiosos/kit-ore-e-confie...`) |
| `admin/index.html` | Painel: produtos com custo e lucro, fotos e vídeo, promoções, relatórios, usuários e troca de senha |
| `data/catalogo.json` | Catálogo de partida: 68 peças, categorias, coleções e temas sazonais. O site usa este arquivo enquanto o Supabase não estiver configurado |
| `assets/` | Logo, fotos e vídeos das peças |
| `sql/` | Banco: 001 tabelas e acesso, 002 eventos dos relatórios, 003 custo, tags e promoções, 004 carga dos 68 produtos |
| `supabase/functions/painel-usuarios` | Função que convida e remove usuários do painel |

## Como colocar no ar

### 1. Supabase (já feito pelo Claude em 02/10/2026, projeto `ydnanmpqwbjzskovnhyh`)
- SQL 001, 002, 003 e 005 aplicados. O 004 é só alternativa ao botão de importação do painel.
- Função `painel-usuarios` publicada.
- Site e painel já apontam para o projeto (URL e chave anon pública no começo do `index.html`, `404.html` e `admin/index.html`).

Falta, no painel do Supabase:
1. Authentication > Users > **Add user**: o e-mail do Pedro, com a senha que ele escolher. A conta vira administradora sozinha.
2. Authentication > Users > **Invite user**: o e-mail da Kamilla. Ela cria a senha pelo e-mail e também vira administradora sozinha.
3. Authentication > URL Configuration: Site URL `https://mimori3d.com.br` e, em Redirect URLs, `https://mimori3d.com.br/admin/`.
4. Entrar em `https://mimori3d.com.br/admin/` e clicar em **Importar o catálogo** (uma vez só).

### 2. GitHub Pages
1. Suba esta pasta para um repositório no GitHub.
2. Settings > Pages: Source "Deploy from a branch", branch `main`, pasta `/ (root)`.
3. O arquivo `CNAME` já aponta para `mimori3d.com.br`.

### 3. Domínio na Hostinger (DNS)
No hPanel, em Domínios > DNS, deixe assim:
- 4 registros **A** em `@`: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
- 1 registro **CNAME** em `www` apontando para `<seu-usuario>.github.io`
Depois, em Settings > Pages, marque **Enforce HTTPS** quando liberar.

## Dia a dia
- Produto, preço, foto, promoção e usuário: tudo pelo painel em `/admin`.
- Cores, temas sazonais e prateleiras da home ficam em `data/catalogo.json` (`colecoes` e `temas`).
- Mudou `index.html`? Copie para `404.html` também.

## Pendências
- `[CONFIRMAR]` data-limite de pedidos dos temas (`[data-limite]` em `data/catalogo.json`).
- `[CONFIRMAR]` taxa do link de pagamento e valor da hora de mão de obra (`parametros_custo`).
- `[CONFIRMAR]` CNPJ no rodapé, aviso de cookies e licença de uso de cada modelo e foto do criador.
- Fotos do criador e da exceção da §11: trocar pela foto da peça real pelo painel, conforme imprimir.
