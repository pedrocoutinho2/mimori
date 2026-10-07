#!/usr/bin/env python3
"""Gera uma página fixa (index.html) para cada endereço do site, o sitemap.xml e o robots.txt.

Por quê: no GitHub Pages, endereços como /vasos-de-planta só abriam pelo 404.html, com código 404,
e o Google tende a não indexar. Com uma pasta por endereço, cada página responde 200 e tem título e
descrição próprios.

Desde 06/10/2026 cada página também sai com o conteúdo escrito no HTML (categorias, lista de produtos,
descrição), entre <!--estatico--> e <!--/estatico-->, para o Google ler sem depender do JavaScript.
Quando o JS carrega, ele substitui esse conteúdo pela página interativa. A home (index.html da raiz)
também é regravada, com canonical. Os blocos marcados são limpos a cada execução, então rodar de novo
não acumula nada.

Como usar (na pasta do repositório):  python3 ferramentas/gerar-paginas.py
Rode de novo sempre que mudar o index.html ou criar ou renomear produto no painel. Também copia o index.html
(sem o conteúdo fixo) para o 404.html. Lê os produtos publicados do Supabase (só leitura pública, com a chave
anon que já está no index.html). Sem internet, usa data/catalogo.json.
"""
import json, os, re, html, shutil, urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'https://mimori3d.com.br'
MAIN = '<main id="conteudo" tabindex="-1"></main>'

bruto = open(os.path.join(RAIZ, 'index.html'), encoding='utf-8').read()
base = re.sub(r'<!--seo-->.*?<!--/seo-->\n?', '', bruto, flags=re.S)
base = re.sub(r'<!--estatico-->.*?<!--/estatico-->', '', base, flags=re.S)
assert MAIN in base, 'Não achei <main id="conteudo" tabindex="-1"></main> no index.html'

url = re.search(r"const SUPABASE_URL = '([^']*)'", base).group(1)
anon = re.search(r"const SUPABASE_ANON = '([^']*)'", base).group(1)

def supabase(caminho):
    req = urllib.request.Request(f'{url}/rest/v1/{caminho}', headers={'apikey': anon, 'Authorization': f'Bearer {anon}'})
    return json.load(urllib.request.urlopen(req, timeout=30))

try:
    cats = supabase('categorias?select=slug,nome&order=ordem')
    prods = supabase('produtos?select=slug,nome,descricao,categoria:categorias(slug),produto_fotos(caminho,ordem)&publicado=eq.true')
    produtos = [{'slug': p['slug'], 'nome': p['nome'], 'descricao': p['descricao'] or '', 'categoria': (p['categoria'] or {}).get('slug', ''),
                 'foto': (sorted(p['produto_fotos'], key=lambda f: f['ordem']) or [{'caminho': ''}])[0]['caminho']} for p in prods]
    print('Lendo do Supabase:', len(produtos), 'produtos')
except Exception as e:
    print('Supabase indisponível, usando data/catalogo.json:', e)
    d = json.load(open(os.path.join(RAIZ, 'data', 'catalogo.json'), encoding='utf-8'))
    cats = d['categorias']
    produtos = [{'slug': p['slug'], 'nome': p['nome'], 'descricao': p['descricao'], 'categoria': p['categoria'], 'foto': p['fotos'][0]['src'] if p['fotos'] else ''} for p in d['produtos'] if p.get('publicado', True)]

produtos = [p for p in produtos if p['categoria']]
NOME_CAT = {c['slug']: c['nome'] for c in cats}
e = html.escape

def resumo(t, n=155):
    t = re.sub(r'\s+', ' ', re.sub(r'[^\w\s,.!?À-ú$%-]', ' ', t or '')).strip()
    return (t[:n - 1].rsplit(' ', 1)[0] + '…') if len(t) > n else t

def src(foto):
    return foto if foto.startswith('http') else ('/' + foto.lstrip('/') if foto else '')

# ---------- conteúdo fixo, lido pelo Google sem JavaScript ----------
def lista_categorias():
    itens = ''.join(f'<li><a href="{e(c["slug"])}/">{e(c["nome"])}</a> ({sum(1 for p in produtos if p["categoria"] == c["slug"])} peças)</li>' for c in cats)
    return f'<h2>Categorias</h2><ul>{itens}</ul>'

def lista_produtos(ps, titulo='Peças'):
    if not ps: return ''
    itens = ''.join(
        f'<li><a href="{e(p["categoria"])}/{e(p["slug"])}/">'
        + (f'<img src="{e(src(p["foto"]))}" alt="{e(p["nome"])}" width="160" height="160" loading="lazy">' if p['foto'] else '')
        + f'<strong>{e(p["nome"])}</strong></a>'
        + (f'<p>{e(resumo(p["descricao"], 140))}</p>' if p['descricao'] else '') + '</li>' for p in ps)
    return f'<h2>{e(titulo)}</h2><ul>{itens}</ul>'

def descricao_html(t):
    blocos = [b.strip() for b in re.split(r'\n\s*\n', t or '') if b.strip()]
    return ''.join('<p>' + '<br>'.join(e(l) for l in b.splitlines()) + '</p>' for b in blocos)

RODAPE = '<p>Cada peça é feita sob encomenda, na cor que você escolhe, e o pedido fecha com a gente no WhatsApp.</p>'

def pagina(caminho, titulo, descricao, corpo, imagem=''):
    h = base
    h = re.sub(r'<title>.*?</title>', f'<title>{e(titulo)}</title>', h, count=1)
    h = re.sub(r'<meta name="description" content="[^"]*">', f'<meta name="description" content="{e(descricao)}">', h, count=1)
    endereco = f'{SITE}/{caminho}/' if caminho else f'{SITE}/'
    img = imagem if imagem.startswith('http') else (f'{SITE}/{imagem.lstrip("/")}' if imagem else f'{SITE}/assets/fotos/categoria-religiosos.jpg')
    extra = (f'<!--seo--><link rel="canonical" href="{endereco}">\n<meta property="og:title" content="{e(titulo)}">\n'
             f'<meta property="og:description" content="{e(descricao)}">\n<meta property="og:image" content="{e(img)}">\n'
             f'<meta property="og:type" content="website">\n<meta property="og:url" content="{endereco}">\n'
             '<style>.estatico{padding-top:24px;padding-bottom:40px}.estatico ul{list-style:none;padding:0;display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:16px}'
             '.estatico img{display:block;max-width:100%;height:auto;border-radius:12px}.estatico li p{font-size:14px;color:var(--texto2)}</style><!--/seo-->\n')
    h = h.replace('<meta name="theme-color"', extra + '<meta name="theme-color"', 1)
    h = h.replace(MAIN, f'<main id="conteudo" tabindex="-1"><!--estatico--><div class="wrap estatico">{corpo}</div><!--/estatico--></main>', 1)
    pasta = os.path.join(RAIZ, caminho) if caminho else RAIZ
    os.makedirs(pasta, exist_ok=True)
    open(os.path.join(pasta, 'index.html'), 'w', encoding='utf-8').write(h)

# limpa páginas geradas antes (marcadas com o arquivo .gerada)
for slug in [c['slug'] for c in cats] + ['catalogo', 'presentes', 'personalizados', 'para-empresas']:
    p = os.path.join(RAIZ, slug)
    if os.path.isdir(p) and os.path.exists(os.path.join(p, '.gerada')):
        shutil.rmtree(p)

# 404 sai do index limpo, sem canonical e sem conteúdo fixo
open(os.path.join(RAIZ, '404.html'), 'w', encoding='utf-8').write(base)

# home
pagina('', 'Mimori · Seu mundo em 3D',
       re.search(r'<meta name="description" content="([^"]*)">', base).group(1),
       '<h1>Seu mundo em 3D</h1><p>A Mimori faz decoração, presentes e personalizados em 3D: peças religiosas, vasos de planta, chaveiros, '
       'organização para casa, jogos e brinquedos sensoriais.</p>' + RODAPE + lista_categorias() + lista_produtos(produtos[:24], 'Algumas peças'))
urls = ['']

FIXAS = {'catalogo': ('Catálogo · Mimori', 'Todas as peças da Mimori: decoração, religiosos, vasos, chaveiros e brinquedos sensoriais em 3D. Monte a lista e feche no WhatsApp.'),
         'presentes': ('Ideias de presente · Mimori', 'Ache o presente certo por quem vai ganhar e por quanto você quer gastar. Peças em 3D com a cara de quem você ama.'),
         'personalizados': ('Personalizados · Mimori', 'Peças com nome, data, frase ou foto, feitas em 3D. A gente confirma a grafia antes de produzir.'),
         'para-empresas': ('Brindes para empresas · Mimori', 'Brindes com o logo da empresa e o nome de cada pessoa. Peça o orçamento pelo WhatsApp.')}
for slug, (t, d) in FIXAS.items():
    corpo = f'<h1>{e(t.split(" · ")[0])}</h1><p>{e(d)}</p>'
    corpo += ''.join(lista_produtos([p for p in produtos if p['categoria'] == c['slug']], c['nome']) for c in cats) if slug == 'catalogo' else lista_categorias()
    pagina(slug, t, d, corpo); open(os.path.join(RAIZ, slug, '.gerada'), 'w').close(); urls.append(slug)

for c in cats:
    ps = [p for p in produtos if p['categoria'] == c['slug']]
    d = f"{len(ps)} peças de {c['nome'].lower()} feitas em 3D sob encomenda, na cor que você escolhe. Monte a lista e feche no WhatsApp."
    corpo = f'<p><a href="./">Início</a> › {e(c["nome"])}</p><h1>{e(c["nome"])}</h1><p>{e(d)}</p>' + lista_produtos(ps) + lista_categorias()
    pagina(c['slug'], f"{c['nome']} · Mimori", d, corpo)
    open(os.path.join(RAIZ, c['slug'], '.gerada'), 'w').close(); urls.append(c['slug'])

for p in produtos:
    caminho = f"{p['categoria']}/{p['slug']}"
    nc = NOME_CAT.get(p['categoria'], p['categoria'])
    irmaos = [q for q in produtos if q['categoria'] == p['categoria'] and q['slug'] != p['slug']][:8]
    corpo = (f'<p><a href="./">Início</a> › <a href="{e(p["categoria"])}/">{e(nc)}</a> › {e(p["nome"])}</p><h1>{e(p["nome"])}</h1>'
             + (f'<img src="{e(src(p["foto"]))}" alt="{e(p["nome"])}" width="480" height="480">' if p['foto'] else '')
             + (descricao_html(p['descricao']) or f'<p>{e(p["nome"])}, feito em 3D pela Mimori.</p>') + RODAPE
             + lista_produtos(irmaos, f'Mais em {nc}'))
    pagina(caminho, f"{p['nome']} · Mimori", resumo(p['descricao']) or f"{p['nome']}, feito em 3D pela Mimori.", corpo, p['foto'])
    urls.append(caminho)

open(os.path.join(RAIZ, 'sitemap.xml'), 'w', encoding='utf-8').write(
    '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n' +
    ''.join(f'  <url><loc>{SITE}/{u + "/" if u else ""}</loc></url>\n' for u in urls) + '</urlset>\n')
open(os.path.join(RAIZ, 'robots.txt'), 'w', encoding='utf-8').write(f'User-agent: *\nAllow: /\nDisallow: /admin/\nSitemap: {SITE}/sitemap.xml\n')
print('Páginas geradas:', len(urls), '· home com conteúdo fixo e canonical · 404.html atualizado')
