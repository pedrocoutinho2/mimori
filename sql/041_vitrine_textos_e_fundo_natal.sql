-- 041 · Textos da vitrine e imagem de fundo da faixa de Natal (17/10/2026)
-- PENDENTE: aplicar no SQL Editor DEPOIS de subir o index.html e a pasta assets/banners
-- (sem as imagens no ar, a faixa de Natal fica sem fundo até o próximo deploy).
--
-- Por quê: ajustes feitos pelo Pedro no canvas da home em 17/10/2026. Os subtítulos das
-- prateleiras e o texto da data especial de Natal moram na tabela colecoes (SQL 017), não no código.
-- A imagem de fundo da faixa sazonal entra em cor.imagem (desktop) e cor.imagemMob (celular);
-- o index.html passou a ler essas duas chaves, e o painel passou a preservá-las ao salvar as cores.
--
-- Só altera textos e acrescenta duas chaves no JSON de cor do Natal. Não apaga nada.

update public.colecoes set texto = 'As peças que a gente mais ama, pra você amar também! 💜' where slug = 'escolhas';
update public.colecoes set texto = 'Produtos especiais para deixar a sua fé sempre por perto. 🙏' where slug = 'religiosos';
update public.colecoes set texto = 'Diversos modelos de vaso pra sua planta ficar com a sua cara! 🪴' where slug = 'vasos';
update public.colecoes set texto = 'Presentes especiais para dar de lembrança para quem você ama! 💜' where slug = 'ate35';

update public.colecoes
   set texto = 'Produtos exclusivos para deixar o Natal ainda mais especial 🎄',
       cor = coalesce(cor, '{}'::jsonb) || jsonb_build_object(
         'imagem', 'assets/banners/natal-faixa-desktop.jpg',
         'imagemMob', 'assets/banners/natal-faixa-celular.jpg')
 where slug = 'natal';

-- Conferência: deve listar as 5 coleções com o texto novo e a natal com imagem e imagemMob
select slug, texto, cor->>'imagem' as imagem, cor->>'imagemMob' as imagem_celular
  from public.colecoes
 where slug in ('escolhas', 'religiosos', 'vasos', 'ate35', 'natal')
 order by slug;
