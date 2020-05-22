--
-- jpbanczek@gmail.com - 2020
-- github.com/jhoonb/maracaju/
----------------------------------------------------
-- doc.lua compila todos os textos da lei orgânica
-- do Município de Maracaju que estão listados 
-- em ordem no arquivo sumario.lua
---------------------------------------------------
-- gera o arquivo 'lei.md', 'lei.pdf'
---------------------------------------------------
-- lua doc.lua
--

-- diretório onde estão os textos da Lei Orgânica
local DIR = 'textos/'

-- texto para inserir no começo/fim do documento 'lei.md' gerado
-- opc = true para inserir como comentário
local adicionar_fonte = function(opc)
  if not opc then
    return '\n\n*Gerado em ' .. os.date() .. ' - https://github.com/jhoonb/maracaju/*\n\n'
  end

  return '\n\n<!--- Gerado em ' .. os.date() .. ' - https://github.com/jhoonb/maracaju/ -->\n\n'
end

-- gera quebra de página para o Latex
local BREAKPAGE = [[


<div style="page-break-after: always; visibility: hidden"> 
\pagebreak 
</div>


]]


-- retorna string com todo o conteúdo do arquivo
local ler_conteudo = function(arquivo)
  -- [DEBUG]
  -- nome dos arquivos gerados 
  -- print(DIR .. arquivo)
  local f = io.open(DIR .. arquivo, "r")
  local texto = f:read("a")
  f:close()
  return texto 
end


local _select = select 
local _gsub = string.gsub


-- count(s, subs) --> number
-- retorna o número de ocorrências de subs em s
local count = function(s, subs) return _select(2, _gsub(s, subs, "")) end


-- capturar_artigo (s) --> string
-- busca o primeiro e último presente no texto s
-- e devolve uma string no formato (Art. <primeiro> ao <último>)
-- se não existir artigos no texto s, retorna string vazia ''
-- se existir apenas um (1) artigo, retorna (Art. <primeiro>)  
local capturar_artigo = function(s) --> string
  
  local art_inicial, art_final

  local i, j = s:find("**Art. ")
  -- senão encontrou retorna '', pois não há artigo no texto
  if not i then return '' end

  -- se existe a string, o próximo ponto, que encerra o número do artigo
  j = j + 1
  s = s:sub(j) -- avança
  local i, aux = s:find("%.")
  -- senão encontrou é porque está com má formação o texto
  if not i then error("Formatação errada do artigo! Verifique") end

   -- primeiro artigo do texto
  aux = aux - 1
  art_inicial = s:sub(1, aux)
  s = s:sub(aux+1)

  -- procura o último artigo artigo da página 
  while true do
    local i, j = s:find("**Art. ")
    -- caso não encontre outro artigo encerra
    if not i then break end
    j = j + 1
    s = s:sub(j) -- avança 
    local i, aux = s:find("%.")
    if not i then return '' end
    art_final = s:sub(1, aux-1)
    s = s:sub(aux+1)
  end

  if not art_inicial then return '' end

  if not art_final then
    return ' ***(Art. ' .. art_inicial .. ')***'
  end

  return ' ***(Art. ' .. art_inicial .. ' ao ' .. art_final .. ')***' 
end


-- tag_sumario(texto) --> string
-- gera o item do sumário de acordo com o nível
-- o nível é especificado pela quantidade de '#'
local tag_sumario = function(texto) --> string

  -- busca o primeiro e último presente em texto 
  trecho_artigo = capturar_artigo(texto)
  
  local _, j = texto:find("\n")
  
  local tag = texto:sub(1, j-1)
  
  local n = count(tag, "#")

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


-- readme()
-- cria o arquivo README.md
-- [TODO]
local readme = function()
  print("em desenvolvimento...")
end


-- pdf()
-- cria o PDF (a partir do lei.md)
local pdf = function()
  os.execute('pandoc lei.md -o lei.pdf')
end


--
local doc = function()

  local sumario = require('sumario')
  local texto_lei = ""
  local texto_sumario = "\n\n**SUMÁRIO** \n\n"

  for i = 1, #sumario do
    local texto = ler_conteudo(sumario[i])
    texto_lei = texto_lei .. texto .. "\n\n"
    texto_sumario = texto_sumario .. tag_sumario(texto)
  end

  local capa = ler_conteudo("CAPA.md")
  local texto_inicial = ler_conteudo("TEXTO-INICIAL.md")
  local texto_final = ler_conteudo("TEXTO-FINAL.md")

  -- junta todos os textos na ordem que será gerado
  texto_lei = adicionar_fonte() .. capa .. BREAKPAGE .. 
  texto_sumario .. BREAKPAGE .. texto_inicial .. BREAKPAGE ..
  texto_lei .. BREAKPAGE .. texto_final .. BREAKPAGE .. 
  adicionar_fonte() .. BREAKPAGE

  f = io.open("lei.md", "w")
  f:write(texto_lei)
  f:close()

end

--------------------------------------------
print("\t ### doc.lua - github.com/jhoonb/maracaju ###\n\n")

print("[doc.lua] --> coletando textos .md ...")
-- gera o arquivo lei.md
doc()
print("\t---> lei.md gerado")
-- gerar README.md
print("[doc.lua] --> criando README.md ...")
readme()
print("\t---> README.md gerado")
-- gerar pdf
print("[doc.lua] --> criando lei.pdf ...")
pdf()
print("\t---> lei.pdf gerado.")