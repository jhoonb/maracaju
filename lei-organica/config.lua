--
-- jpbanczek@gmail.com - 2020
-- github.com/jhoonb/maracaju
---------------------------------------------------------------------
-- config.lua - configuração para gerar os documentos 
-- textos da Lei Orgânica do Município de Maracaju
-- listados em ordem.
-- os documentos .md devem estar no diretório config.dir
---------------------------------------------------------------------


local config = {}

-- linguagem para o pdf (latex)
config.lang = '---\nlang: pt-BR\n...\n'


-- diretório onde estão os textos da Lei Orgânica
config.dir = 'textos/'

-- version texto para inserir no começo/fim do documento gerado
-- para não inserir o version deixe como string vazia ''
-- config.version = ''
config.version = '\n\n###### *Gerado em ' .. os.date() .. ' - https://github.com/jhoonb/maracaju/*\n\n'

-- gera quebra de página para o Latex
config.pagebreak = '\n\n \\pagebreak \n\n'

-- arquivo da capa 
config.capa = 'CAPA.md'

-- arquivo do texto inicial, pos capa.
config.texto_inicial = 'TEXTO-INICIAL.md'

-- arquivo do texto final 
config.texto_final = 'TEXTO-FINAL.md'

--
-- todos os arquivos em ordem de inserção no texto
--
config.sumario = {
	"TITULO-I.md",
	"TITULO-II.md",
	"TITULO-III.md",
	"TITULO-III-CAPITULO-I.md", 
	"TITULO-III-CAPITULO-II.md",
	"TITULO-III-CAPITULO-II-SECAO-I.md",
	"TITULO-III-CAPITULO-II-SECAO-II.md",
	"TITULO-III-CAPITULO-II-SECAO-III.md",
	"TITULO-III-CAPITULO-II-SECAO-IV.md",
	"TITULO-III-CAPITULO-II-SECAO-V.md",
	"TITULO-III-CAPITULO-II-SECAO-VI.md",
	"TITULO-III-CAPITULO-II-SECAO-VII.md",
	"TITULO-III-CAPITULO-II-SECAO-VIII.md", 
	"TITULO-III-CAPITULO-II-SECAO-IX.md", 
	"TITULO-III-CAPITULO-II-SECAO-X.md",
	"TITULO-III-CAPITULO-II-SECAO-XI.md",
	"TITULO-III-CAPITULO-II-SECAO-XII.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII-SUBSECAO-I.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII-SUBSECAO-II.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII-SUBSECAO-III.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII-SUBSECAO-IV.md",
	"TITULO-III-CAPITULO-II-SECAO-XIII-SUBSECAO-V.md",
	"TITULO-III-CAPITULO-II-SECAO-XIV.md",
	"TITULO-III-CAPITULO-II-SECAO-XIV-SUBSECAO-II.md",
	"TITULO-III-CAPITULO-II-SECAO-XIV-SUBSECAO-III.md",
	"TITULO-III-CAPITULO-III.md",
	"TITULO-III-CAPITULO-III-SECAO-I.md",
	"TITULO-III-CAPITULO-III-SECAO-II.md",
	"TITULO-III-CAPITULO-III-SECAO-III.md",
	"TITULO-III-CAPITULO-III-SECAO-IV.md",
	"TITULO-III-CAPITULO-III-SECAO-V.md",
	"TITULO-III-CAPITULO-III-SECAO-VI.md",
	"TITULO-III-CAPITULO-III-SECAO-VII.md",
	"TITULO-IV.md",
	"TITULO-IV-CAPITULO-I.md",
	"TITULO-IV-CAPITULO-II.md",
	"TITULO-IV-CAPITULO-III.md",
	"TITULO-IV-CAPITULO-IV.md",
	"TITULO-IV-CAPITULO-V.md",
	"TITULO-IV-CAPITULO-V-SECAO-I.md",
	"TITULO-IV-CAPITULO-V-SECAO-II.md",
	"TITULO-IV-CAPITULO-V-SECAO-III.md",
	"TITULO-IV-CAPITULO-V-SECAO-IV.md",
	"TITULO-IV-CAPITULO-V-SECAO-V.md",
	"TITULO-IV-CAPITULO-V-SECAO-VI.md",
	"TITULO-IV-CAPITULO-V-SECAO-VII.md",
	"TITULO-IV-CAPITULO-V-SECAO-VIII.md",
	"TITULO-IV-CAPITULO-V-SECAO-IX.md",
	"TITULO-IV-CAPITULO-VI.md",
	"TITULO-IV-CAPITULO-VII.md",
	"TITULO-IV-CAPITULO-VIII.md",
	"TITULO-IV-CAPITULO-VIII-SECAO-I.md",
	"TITULO-IV-CAPITULO-VIII-SECAO-II.md",
	"TITULO-IV-CAPITULO-VIII-SECAO-III.md",
	"TITULO-IV-CAPITULO-IX.md",
	"TITULO-IV-CAPITULO-IX-SECAO-I.md",
	"TITULO-IV-CAPITULO-IX-SECAO-II.md",
	"TITULO-IV-CAPITULO-X.md",
	"TITULO-IV-CAPITULO-X-SECAO-I.md",
	"TITULO-IV-CAPITULO-X-SECAO-II.md",
	"TITULO-IV-CAPITULO-X-SECAO-III.md",
	"TITULO-IV-CAPITULO-X-SECAO-IV.md",
	"TITULO-IV-CAPITULO-X-SECAO-V.md",
	"TITULO-IV-CAPITULO-X-SECAO-VI.md",
	"TITULO-IV-CAPITULO-X-SECAO-VII.md",
	"TITULO-V.md"
}

return config