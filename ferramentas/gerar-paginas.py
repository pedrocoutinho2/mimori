#!/usr/bin/env python3
"""Gera uma página fixa (index.html) para cada endereço do site, o sitemap.xml e o robots.txt.

Por quê: no GitHub Pages, endereços como /vasos-de-planta só abriam pelo 404.html, com código 404,
e o Google tende a não indexar. Com uma pasta por endereço, cada página responde 200 e tem título e
descrição próprios.

Como usar (na pasta do repositório):  python3 ferramentas/gerar-paginas.py
Rode de novo sempre que mudar o index.html ou criar ou renomear produto no painel. Também copia o index.html para o 404.html. Lê os produtos publicados do Supabase
(só leitura pública, com a chave anon que já está no index.html). Sem internet, usa data/catalogo.json.
"""
import json, os, re, html, shutil, urllib.request

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'https://mimori3d.com.br'
base = open(os.path.join(RAIZ, 'index.html'), encoding='utf-8').read()
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

def resumo(t, n=155):
    t = re.sub(r'\s+', ' ', re.sub(r'[^\w\s,.!?À-ú$%-]', ' ', t or '')).strip()
    return (t[:n - 1].rsplit(' ', 1)[0] + '…') if len(t) > n else t

def pagina(caminho, titulo, descricao, imagem=''):
    h = base
    h = re.sub(r'<title>.*?</title>', f'<title>{html.escape(titulo)}</title>', h, count=1)
    h = re.sub(r'<meta name="description" content="[^"]*">', f'<meta name="description" content="{html.escape(descricao)}">', h, count=1)
    img = imagem if imagem.startswith('http') else (f'{SITE}/{imagem}' if imagem else f'{SITE}/assets/fotos/categoria-religiosos.jpg')
    extra = (f'<link rel="canonical" href="{SITE}/{caminho}">\n<meta property="og:title" content="{html.escape(titulo)}">\n'
             f'<meta property="og:description" content="{html.escape(descricao)}">\n<meta property="og:image" content="{html.escape(img)}">\n'
             f'<meta property="og:type" content="website">\n<meta property="og:url" content="{SITE}/{caminho}">\n')
    h = h.replace('<meta name="theme-color"', extra + '<meta name="theme-color"', 1)
    pasta = os.path.join(RAIZ, caminho)
    os.makedirs(pasta, exist_ok=True)
    open(os.path.join(pasta, 'index.html'), 'w', encoding='utf-8').write(h)

# limpa páginas geradas antes (marcadas com o arquivo .gerada)
for slug in [c['slug'] for c in cats] + ['catalogo', 'presentes', 'personalizados', 'para-empresas']:
    p = os.path.join(RAIZ, slug)
    if os.path.isdir(p) and os.path.exists(os.path.join(p, '.gerada')):
        shutil.rmtree(p)

urls = ['']
FIXAS = {'catalogo': ('Catálogo · Mimori', 'Todas as peças da Mimori: decoração, religiosos, vasos, chaveiros e brinquedos sensoriais em 3D. Monte a lista e feche no WhatsApp.'),
         'presentes': ('Ideias de presente · Mimori', 'Ache o presente certo por quem vai ganhar e por quanto você quer gastar. Peças em 3D com a cara de quem você ama.'),
         'personalizados': ('Personalizados · Mimori', 'Peças com nome, data, frase ou foto, feitas em 3D. A gente confirma a grafia antes de produzir.'),
         'para-empresas': ('Brindes para empresas · Mimori', 'Brindes com o logo da empresa e o nome de cada pessoa. Peça o orçamento pelo WhatsApp.')}
for slug, (t, d) in FIXAS.items():
    pagina(slug, t, d); open(os.path.join(RAIZ, slug, '.gerada'), 'w').close(); urls.append(slug)
for c in cats:
    n = sum(1 for p in produtos if p['categoria'] == c['slug'])
    pagina(c['slug'], f"{c['nome']} · Mimori", f"{n} peças de {c['nome'].lower()} feitas em 3D sob encomenda, na cor que você escolhe. Monte a lista e feche no WhatsApp.")
    open(os.path.join(RAIZ, c['slug'], '.gerada'), 'w').close(); urls.append(c['slug'])
for p in produtos:
    if not p['categoria']: continue
    caminho = f"{p['categoria']}/{p['slug']}"
    pagina(caminho, f"{p['nome']} · Mimori", resumo(p['descricao']) or f"{p['nome']}, feito em 3D pela Mimori.", p['foto'])
    urls.append(caminho)

open(os.path.join(RAIZ, 'sitemap.xml'), 'w', encoding='utf-8').write(
    '<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n' +
    ''.join(f'  <url><loc>{SITE}/{u}</loc></url>\n' for u in urls) + '</urlset>\n')
open(os.path.join(RAIZ, 'robots.txt'), 'w', encoding='utf-8').write(f'User-agent: *\nAllow: /\nDisallow: /admin/\nSitemap: {SITE}/sitemap.xml\n')
shutil.copy(os.path.join(RAIZ, 'index.html'), os.path.join(RAIZ, '404.html'))
print('Páginas geradas:', len(urls), '· 404.html atualizado')
