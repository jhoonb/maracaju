--
-- jpbanczek@gmail.com - 2020
-- github.com/jhoonb/maracaju/lei-organica
----------------------------------------------------
-- doc.lua compila todos os textos da lei orgânica
-- do Município de Maracaju que estão listados 
-- em ordem no arquivo sumario.lua
-- gera o arquivo 'lei.md'
---------------------------------------------------
-- lua doc.lua 
--


local _select = select 
local _gsub = string.gsub


-- count string
local count = function(s, subs) return _select(2, _gsub(s, subs, "")) end


-- find_artigo
local find_artigo = function(s)
  
  local art_inicial, art_final

  local i, j = s:find("**Art. ")
  if not i then return '' end
  j = j + 1
  s = s:sub(j) -- avança
  
  local i, aux = s:find("%.")
  if not i then error("Formatação errada do artigo! Verifique") end
  aux = aux - 1
  -- primeiro artigo da página
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


-- gera item do sumário
local tag_sumario = function(texto)

  trecho_artigo = find_artigo(texto)
  
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


-- criar o arquivo readme
-- [TODO]
local readme = function()
end


--
local doc = function()

  local sumario = require('sumario')
  local texto_lei = ""
  local texto_sumario = "**SUMÁRIO** \n\n"

  for i = 1, #sumario do
  	local f = io.open(sumario[i], "r")
    local texto = f:read("a")

    texto_lei = texto_lei .. texto .. "\n\n"
    texto_sumario = texto_sumario .. tag_sumario(texto)
    f:close()
  end

  local source = '\n\n<!--- github.com/jhoonb/maracaju -->\n\n'
  -- adiciona o sumário no fim:
  texto_lei = texto_lei .. texto_sumario .. source

  f = io.open("lei.md", "w")
  f:write(texto_lei)
  f:close()

end

-- gera o arquivo lei.md
doc()
-- gerar README.md
readme()