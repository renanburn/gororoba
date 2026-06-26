---
layout: default
title: gororoba
---

# gororoba

Linter de voz para português brasileiro. Aponta trechos de slop de IA (texto genérico,
requentado, traduzido do inglês, sem voz) por eixo, igual o ESLint aponta código.

## O que é

Uma régua que você roda no seu texto e que diz, por eixo, o que está genérico: "isto tem
3 conectivos de tradução, 2 voz passiva e 1 clichê de IA". Roda local e no seu CI, em
cima de [Vale](https://vale.sh).

## O que NÃO é

Não detecta autoria de IA. A pergunta aqui é "vale a pena ler?", não "quem escreveu?".

Os detectores de autoria (GPTZero, Turnitin AI) têm viés comprovado contra quem escreve
simples ou não é nativo, e foram desligados por várias universidades. O gororoba foge
disso de propósito. Slop é propriedade do texto, medível e acionável. Autoria não é. Tem
IA bem usada que sai limpa, e tem gente escrevendo gororoba pura sem máquina nenhuma.

## O exemplo rodando

Isto é a saída real de `vale tests/gororoba.md`, não um mockup. O fixture sujo entra, o
linter aponta cada trecho com o eixo, a regra e a severidade:

```
3:1    warning     [cliche-ia] 'No mundo de hoje': abertura de garganta limpa.
3:38   warning     [conectivo-traducao] 'vale ressaltar que': conectivo de tradução.
4:50   warning     [voz-passiva] 'foi observado': voz passiva ou impessoal.
8:10   error       [cliche-ia] 'de tirar o fôlego': clichê de IA. Corta.
8:28   suggestion  [cliche-ia] travessão como recurso. Use vírgula, ponto ou dois pontos.
10:1   error       [cliche-ia] 'Ótima pergunta': clichê de IA. Corta.
12:42  warning     [voz-passiva] gerundismo de call center: use 'envio' no lugar de 'Vou estar enviando'.

✖ 5 errors, 16 warnings and 2 suggestions in 1 file.
```

## O anteparo que importa (antes → depois)

O risco mortal de uma régua dessas é marcar mineirês ou fala popular como slop. O
fixture `tests/voz-limpa.md` trava isso. Texto de voz real entra e tem que sair com zero
alerta. Isto é a saída real de `vale tests/voz-limpa.md`:

```
✔ 0 errors, 0 warnings and 0 suggestions in 1 file.
```

A frase "Cê viu o trem que o sô falou, uai?" passa limpa. O CI quebra se algum sinal
vazar pra cima dela. Isto roda a cada push, então não fica no campo da promessa.

## Os 3 eixos da v0

| Eixo | O que pega |
|---|---|
| `conectivo-traducao` | `vale ressaltar`, `nesse sentido`, `em suma`, `ademais` |
| `voz-passiva` | `foi observado`, `pode-se notar`, gerundismo de call center |
| `cliche-ia` | `ótima pergunta`, abertura de garganta limpa, travessão como recurso, paralelismo negativo |

Ritmo, brasilidade e densidade ficam pra depois. São subjetivos e baixam a concordância
entre anotadores. A v0 fica nos 3 eixos objetivos.

## Estado honesto

Esta é a Camada 2, o linter. Funciona e roda em CI hoje. A Camada 1, o dataset público
anotado por dois humanos com concordância (kappa) medida, ainda está em construção. Sem
ela, isto é uma régua útil. Com ela, vira uma régua provada. Não vai virar "benchmark"
antes de o kappa estar na mão.

| Camada | O que é | Estado |
|---|---|---|
| Camada 2 | o linter Vale, 7 eixos, CI | pronto, roda hoje |
| Camada 1 | dataset anotado + kappa por eixo | em construção, 0 trechos |

O cético tem um lugar pra cavar: o [posicionamento](docs/POSICIONAMENTO.md) responde de
frente "isso é só regex?", "e os falsos positivos?" e "por que confiar sem o kappa?".

## Crédito

Vem da régua anti-slop papo-reto, que o autor já mantinha, e do
[stop-slop](https://github.com/hardikpandya/stop-slop) de Hardik Pandya (MIT), que
ajudou a formalizar a ideia pro português. Licença MIT.

## Como rodar

```bash
brew install vale
git clone https://github.com/renanburn/gororoba && cd gororoba
vale tests/gororoba.md
```

Repo: [github.com/renanburn/gororoba](https://github.com/renanburn/gororoba).

<!--
COMO ATIVAR O GITHUB PAGES (só depois de o repo virar público):
Pages de repo privado exige plano pago, então não ative enquanto for privado.
Quando virar público:
  Settings > Pages > Source: "Deploy from a branch" > Branch: main > pasta: / (root) > Save.
O tema jekyll-theme-minimal e este index.md já estão prontos. A página sobe sozinha.
Ou via CLI:
  gh api -X POST repos/renanburn/gororoba/pages -f "source[branch]=main" -f "source[path]=/"
-->
