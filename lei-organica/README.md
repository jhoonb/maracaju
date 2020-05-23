# Lei Orgânica

* Lei Orgânica do Município de Maracaju/MS:

- [Formato *HTML*](https://github.com/jhoonb/maracaju/blob/master/lei-organica/lei.html)

	- [**ver online**: Lei Orgânica.](http://htmlpreview.github.io/?https://github.com/jhoonb/maracaju/blob/master/lei-organica/lei.html)  

- [Formato *Markdown*](https://github.com/jhoonb/maracaju/blob/master/lei-organica/lei.md)

- [Formato *PDF*](https://github.com/jhoonb/maracaju/blob/master/lei-organica/lei.pdf)


## Uso

Para gerar o arquivo `lei.md`, `lei.pdf` e `lei.html` execute o programa `doc.lua`:

```bash
lua doc.lua
```


### Atualizações

- [23/05/2020]: 

	- refatoração do código;

	- adicionado módulo `lstr` [github.com/jhoonb/lstr](github.com/jhoonb/lstr);

	- nova implementação no arquivo `config.lua` (antes: `sumario.lua`);

	- correção do PDF para hifenizar no formato pt-BR (latex);

	- implementada a função para gerar arquivo: `lei.html`;



### Dependências:

- [Linguagem Lua](https://www.lua.org/) 

- Pandoc/Latex com pacote português:

```bash
sudo apt-get install pandoc texlive-latex-base texlive-fonts-recommended texlive-extra-utils texlive-latex-extra install texlive-lang-portuguese
```

- - - 

###### *Jhonathan P. Banczek - 2020 - Escrito em [Lua](https://www.lua.org/)*

