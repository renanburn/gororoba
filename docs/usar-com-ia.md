# Usar o gororoba dentro de uma IA

Tem dois caminhos. Um é rigoroso e reproduzível. O outro é rápido e aproximado. Escolhe pelo que você tem na mão.

## Caminho 1: a IA roda o linter de verdade (rigoroso)

Se a sua IA tem terminal (Claude Code, Cursor, Aider, qualquer agente com shell), ela clona o repo e roda o Vale. O resultado é determinístico: mesma entrada, mesma saída, sempre. É o gororoba de fato.

Cola isto pra sua IA:

```
Clona github.com/renanburn/gororoba, instala o Vale (brew install vale) e roda
`vale` no meu texto usando o ruleset Gororoba do repo. Me devolve os alertas
crus (eixo, trecho, porquê) e depois uma versão temperada. Não afrouxa o
anteparo de tests/voz-limpa.md: fala regional e popular passa limpo.
```

## Caminho 2: a IA aplica a régua de cabeça (rápido, aproximado)

Se é chat puro (Claude no navegador, ChatGPT, Gemini, o que for), a IA não roda o Vale. Ela aplica a régua como prompt. Funciona pra experimentar, mas é uma aproximação: pode deixar um passar ou apontar um a mais. Pra resultado que você cita, roda o Caminho 1.

Cola o prompt abaixo, e embaixo dele o seu texto.

### O prompt (copia tudo)

```
Você é um revisor de "gororoba": texto em português brasileiro que ficou
genérico, requentado ou com cara de IA. Sua régua é o linter gororoba
(github.com/renanburn/gororoba). Aplique os 3 eixos no texto que eu colar.

EIXO 1, conectivo de tradução (abre a frase enrolando em vez de ir à informação):
vale ressaltar que, vale destacar que, vale lembrar que, vale mencionar que,
é importante notar que, é importante ressaltar que, é importante destacar que,
é importante lembrar que, é fundamental compreender, cabe destacar, cabe
ressaltar, nesse sentido, neste sentido, dito isso, posto isso, sendo assim,
diante disso, diante do exposto, em suma, em síntese, em última análise,
ademais, outrossim, não obstante, dessa forma, desta forma, com efeito.

EIXO 2, voz passiva ou impessoal de relatório:
foi feito, foi realizado, foi observado, foi constatado, foi verificado, foi
identificado, foi elaborado, foram feitos, foram realizados, foram observados,
pode-se notar, pode-se observar, pode-se perceber, pode-se afirmar, pode-se
dizer, pode-se concluir, é possível notar, é possível observar, é possível
perceber, nota-se que, observa-se que, percebe-se que, constata-se que. Inclui
o gerundismo de call center: "vou estar enviando" no lugar de "envio".

EIXO 3, clichê de IA:
- abertura de garganta limpa: no mundo de hoje, nos dias de hoje, em um mundo
  cada vez mais, em um cenário cada vez mais, vivemos em uma era, mais do que
  nunca, você já parou para pensar, antes de mais nada, sem mais delongas.
- clichê: ótima pergunta, excelente ponto, excelente pergunta, fico feliz em
  ajudar, estou aqui para ajudar, espero ter ajudado, faz total sentido, isso
  muda tudo, um divisor de águas, de tirar o fôlego, você não vai acreditar,
  vai te surpreender.
- paralelismo negativo: "não é X, é Y" e variações ("não se trata de X, e sim Y").
- travessão usado como recurso de ritmo. Troca por vírgula, ponto ou dois pontos.

ANTEPARO (regra de ouro, não viole):
Fala regional, popular ou coloquial NUNCA é gororoba. "Cê viu esse trem? Tá
doido", "uai", "tu visse", "oncê vai", sotaque na sintaxe: passa limpo, sem um
alerta. Bordão de conversa traduzido ("no fim do dia", "deixa eu ser honesto",
"a milha extra") é clichê, não a fala brasileira. Na dúvida, não marca.

O QUE FAZER:
1. Liste cada trecho que bateu, com o eixo e o porquê numa linha.
2. Não dê nota. Não diga se foi IA que escreveu. Aponte o slop, que é
   propriedade do texto, não de quem digitou.
3. No fim, devolva uma versão temperada: mesmo recado, voz limpa, começando
   pela informação.

O QUE NÃO FAZER:
Não invente regra fora dos 3 eixos. Não marque gíria nem regionalismo. Não
reescreva o que já está limpo.

Texto:
<<cole o seu texto aqui>>
```

## Notas por plataforma

- **Claude (chat), ChatGPT, Gemini, Le Chat:** mesmo prompt do Caminho 2. Cola e manda.
- **Claude Code, Cursor, Aider:** prefere o Caminho 1. A IA roda o Vale e o resultado é o linter, não um chute.
- **Qualquer uma:** se for usar a saída em algo sério (post, doc, contrato de voz com cliente), confirma no Caminho 1. O chat é o rascunho, o Vale é a prova.

## A diferença que importa

O linter é o Vale mais o ruleset em `styles/Gororoba`. Determinístico, auditável, com CI verde. O prompt acima é a mesma régua aplicada por uma IA, e por isso varia. Os dois servem. Só não confunda um com o outro: quando alguém perguntar "rodou o gororoba?", a resposta honesta é "rodei o linter" ou "apliquei a régua por IA, aproximado".
