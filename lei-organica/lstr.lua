--[[
  Jhonathan Paulo Banczek. 2020 - jpbanczek@gmail.com - github.com/jhoonb
--]]

---------------------------------  
-- functions:
-- ------------------------------
-- lstr.count(s, subs)
-- lstr.endwith(s, subs)
-- lstr.join(s, sep)
-- lstr.replace(s, old, new)
-- lstr.split(s, sep)
-- lstr.startwith(s, subs)
-- lstr.strip(s)
-- lstr.trim(s)


-- locals functions
local _sub = string.sub
local _gsub = string.gsub
local _match = string.match
local _find = string.find
local _concat = table.concat
local _select = select
local _assert = assert
local _type = type


local lstr = {}


-- count(s, subs) retorna o número de ocorrências 
-- da string subs em s
-------------------------------------------------
-- param s: string
-- param sub: string
-- return: number 
-------------------------------------------------
lstr.count = function(s, subs)
  return _select(2, _gsub(s, subs, ""))
end

-- endwith(s, subs) retorna true se a string s termina
-- com a string sub, do contrário retorna false
-------------------------------------------------
-- param s: string
-- param subs: string
-- return: boolean
lstr.endwith = function(s, subs)
  local ns, nsubs = #s, #subs-1
  nsubs = ns - nsubs
  return _sub(s, nsubs, ns) == subs
end


-- join(t, sep) retorna um nova string
-- onde cada elemento da table t é concatenado
-- usando como separador sep
-------------------------------------------------
-- param t: table, ex.: {"lua", "language"}
-- param sep: string, default: ""
-- return: string
-------------------------------------------------
lstr.join = function(t, sep)
  sep = sep or "" 
  return _concat(t, sep)
end


-- replace(s, old, new) retorna uma nova string 
-- substituindo a string old em s pela string new
-------------------------------------------------
-- param s: string
-- param old: string
-- param new: string
-- return: string  
-------------------------------------------------
lstr.replace = function(s, old, new)
  return _select(1, _gsub(s, old, new))
end


-- split(s, sep) split divide s que contém um delimitador sep 
-- em uma lista (table) de substrings entre esse delimitador.  
-------------------------------------------------
-- param s: string
-- param sep: string
-- return: table
-------------------------------------------------
lstr.split = function(s, sep)
  _assert((_type(sep) == "string") and (#sep > 0))
  local i
  local start = 1
  local t = {}
  while true do 
    i = _find(s, sep, start, true)
    if not i then
      t[#t+1] = _sub(s, start)
      break
    else
      t[#t+1] = _sub(s, start, i-1)
      start = i + #sep
    end
  end
  return t
end


-- startwith(s, subs) retorna true se a string s
-- começa com a string subs, do contrário returna false
-------------------------------------------------
-- param s: string
-- param subs: string
-- return: boolean
-------------------------------------------------
lstr.startwith = function(s, subs)
  return _sub(s, 1, #subs) == subs
end


-- strip(s) remove os espaços no inicio/ fim de s
-------------------------------------------------
-- param s: string
-- return: string
-------------------------------------------------
lstr.strip = function(s)
  return _match(s, "^%s*(.-)%s*$") -- "%s*(.-)%s*$"
end


-- lstr.trim(str, sep) referência para lstr.strip
-------------------------------------------------
lstr.trim = lstr.strip


return lstr
