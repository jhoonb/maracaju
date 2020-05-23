--
-- jpbanczek@gmail.com - 2020
-- github.com/jhoonb/maracaju
---------------------------------------------------------------------
-- doc.lua compila todos os textos da lei orgânica
-- do Município de Maracaju que estão listados 
-- em ordem no arquivo config.lua
---------------------------------------------------------------------
-- gera o arquivo lei.md, lei.pdf e lei.html


-- módulo para manipulação de strings, fonte: github.com/jhoonb/lstr
local lstr = require('lstr')


-- ler_conteudo(arquivo) --> string
---------------------------------------------------------------------
-- retorna todo contéudo do arquivo 'arquivo'
---------------------------------------------------------------------
-- param: arquivo (string)
-- retorno: texto (string)
-- 
local ler_conteudo = function(arquivo)
  -- [DEBUG]
  -- nome dos arquivos gerados 
  -- print(arquivo)
  local f = io.open(arquivo, "r")
  local texto = f:read("a")
  f:close()
  return texto 
end


-- capturar_artigo (texto) --> string
---------------------------------------------------------------------
-- busca o primeiro e último presente na string texto
-- e devolve uma string no formato (Art. <primeiro> ao <último>)
-- se não existir artigos no texto s, retorna string vazia ''
-- se existir apenas um (1) artigo, retorna (Art. <primeiro>)
---------------------------------------------------------------------
-- param.: texto (string)
-- retorno: s (string)
--
local capturar_artigo = function(texto) --> string
  
  local art_inicial, art_final

  local i, j = texto:find("**Art. ")
  -- senão encontrou retorna '', pois não há artigo no texto
  if not i then return '' end

  -- se existe a string, o próximo ponto, que encerra o número do artigo
  j = j + 1
  texto = texto:sub(j) -- avança
  local i, aux = texto:find("%.")
  -- senão encontrou é porque está com má formação o texto
  if not i then error("Formatação errada do artigo! Verifique") end

   -- primeiro artigo do texto
  aux = aux - 1
  art_inicial = texto:sub(1, aux)
  texto = texto:sub(aux+1)

  -- procura o último artigo artigo da página 
  while true do
    local i, j = texto:find("**Art. ")
    -- caso não encontre outro artigo encerra
    if not i then break end
    j = j + 1
    texto = texto:sub(j) -- avança 
    local i, aux = texto:find("%.")
    if not i then return '' end
    art_final = texto:sub(1, aux-1)
    texto = texto:sub(aux+1)
  end

  local s = ''

  if not art_inicial then return s end

  if not art_final then s = ' ***(Art. ' .. art_inicial .. ')***'
  else s = ' ***(Art. ' .. art_inicial .. ' ao ' .. art_final .. ')***' end

  return s
end


--
-- tag_sumario(texto) --> string
-----------------------------------------------------------
-- gera o item do sumário de acordo com o nível
-- o nível é especificado pela quantidade de '#'
-----------------------------------------------------------
-- param.: texto (string)
-- retorno: string
--
local tag_sumario = function(texto) --> string

  -- busca o primeiro e último artigo presente em texto 
  trecho_artigo = capturar_artigo(texto)
  
  local _, j = texto:find("\n")
  
  local tag = texto:sub(1, j-1)
  
  -- Heading level
  local n = lstr.count(tag, "#")

  if n == 0 then 
    return trecho_artigo .. "\n\n" 
  end

  if n == 1 or n == 2 then 
    return tag:sub(n+2) .. trecho_artigo .. "\n\n" 
  end

  if n == 3 then 
    return "- " .. tag:sub(n+2) .. trecho_artigo .. "\n\n" 
  end

  if n == 4 then 
    return "\t - " .. tag:sub(n+2) .. trecho_artigo .. "\n\n" 
  end

  if n == 5 then 
    return "\t\t - " .. tag:sub(n+2) .. trecho_artigo .. "\n\n" 
  end

end 



-- html()
---------------------------------------------------------------------
-- gera o arquivo lei.html
--
local html = function()
  os.execute('pandoc lei.md -o lei.html')
end


-- pdf()
---------------------------------------------------------------------
-- cria o PDF (a partir do arquivo temp_lei.md)
-- conversão realizada pelo PANDOC
--
local pdf = function()
  os.execute('pandoc temp_lei.md -o lei.pdf')
end


-- doc()
---------------------------------------------------------------------
-- função principal
---------------------------------------------------------------------
local doc = function()

  -- carrega o arquivo de configuração
  local config = require('config')
  -- variável para concatenar o texto da lei
  local texto_lei = ""
  -- variável para concatenar o sumário
  local texto_sumario = "\n\n**SUMÁRIO** \n\n"

  for i = 1, #config.sumario do
    local texto = ler_conteudo(config.dir .. config.sumario[i])
    texto_lei = texto_lei .. texto .. "\n\n"
    texto_sumario = texto_sumario .. tag_sumario(texto)
  end

  -- junta todos os textos na ordem que será gerado
  texto_lei = config.version .. 
  ler_conteudo(config.dir .. config.capa) .. 
  config.pagebreak .. 
  texto_sumario .. 
  config.pagebreak .. 
  ler_conteudo(config.dir .. config.texto_inicial) .. 
  config.pagebreak .. 
  texto_lei .. 
  config.pagebreak .. 
  ler_conteudo(config.dir .. config.texto_final) .. 
  config.pagebreak .. 
  config.version .. 
  config.pagebreak

  -- copia para gerar o lei.md sem pagebreak
  copia_texto_lei = lstr.replace(texto_lei, config.pagebreak, '\n\n') 
  f = io.open("lei.md", "w")
  f:write(copia_texto_lei)
  f:close()

  -- adiciona lingua pt-BR para o pandoc/lateX
  -- [necenssário pra gerar a hifenização correta na lingua portuguesa]
  texto_lei = config.lang .. texto_lei

  -- gera o temp_lei.md para a conversão em pdf -- com pagebreak
  -- [temp_lei.md será excluido após o processo de geração do PDF]
  f = io.open("temp_lei.md", "w")
  f:write(texto_lei)
  f:close()

end

-------------------------------------------- 
print("\t[doc.lua - github.com/jhoonb/maracaju]\n\n")

doc() -- gerar arquivo: lei.md
html() -- gerar arquivo: lei.html
pdf() -- -- gerar: lei.pdf
-- após a criação, exclui o arquivo temporario temp_lei.md
os.execute('rm temp_lei.md')
--