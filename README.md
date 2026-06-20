# gororoba

Linter de voz para português brasileiro. Aponta trechos de *slop* de IA (texto
genérico, requentado, traduzido do inglês, sem voz) por eixo, igual o ESLint aponta
código. **Não detecta autoria de IA.** Diz "isto tem 3 conectivos de tradução e 2 voz
passiva", não "isto foi escrito por máquina".

[![Vale](https://github.com/renanburn/gororoba/actions/workflows/vale.yml/badge.svg)](https://github.com/renanburn/gororoba/actions/workflows/vale.yml)

## O que é, e o que não é

Os detectores de autoria de IA (GPTZero, Turnitin AI) têm viés comprovado contra quem
escreve simples ou não é nativo, e foram desligados por várias universidades. gororoba
foge disso de propósito. A pergunta aqui é "vale a pena ler?", não "quem escreveu?".
Genericidade é medível e acionável. Autoria não é.

Slop é propriedade do texto, não de quem segurou o teclado. Tem IA bem usada que sai
limpa, e tem gente escrevendo gororoba pura sem máquina nenhuma.

## Roda em 3 linhas

```bash
brew install vale
git clone https://github.com/renanburn/gororoba && cd gororoba
vale tests/gororoba.md
```

Saída:

```
[conectivo-traducao] 'vale ressaltar que': conectivo de tradução.
[voz-passiva] 'foi observado': voz passiva ou impessoal.
[cliche-ia] 'Ótima pergunta': clichê de IA. Corta.
```

## Os 3 eixos da v0

| Eixo | O que pega |
|---|---|
| `conectivo-traducao` | `vale ressaltar`, `nesse sentido`, `em suma`, `ademais` |
| `voz-passiva` | `foi observado`, `pode-se notar`, gerundismo de call center |
| `cliche-ia` | `ótima pergunta`, abertura de garganta limpa, travessão como recurso, paralelismo negativo |

Ritmo, brasilidade e densidade ficam para depois. São subjetivos e baixam a
concordância entre anotadores. A v0 fica nos 3 eixos objetivos.

## O anteparo que importa

O viés que derrubou os detectores foi penalizar voz simples. gororoba corre o risco
oposto: marcar mineirês ou fala popular como slop. Isso seria a morte da ferramenta.
O fixture `tests/voz-limpa.md` existe pra travar isso: "Cê viu o trem que o sô falou,
uai" passa limpo, sem um alerta. Roda e confere:

```bash
vale tests/voz-limpa.md
```

## Estado honesto

Esta é a Camada 2, o linter. Funciona e roda em CI hoje. A Camada 1, o dataset público
anotado por dois humanos com concordância (kappa) medida, ainda está em construção. Sem
ela, isto é uma régua útil; com ela, vira uma régua provada. Não vou chamar de
"benchmark" antes de ter o kappa na mão.

## Crédito

Vem da minha régua anti-slop, que eu já mantinha antes, e do
[stop-slop](https://github.com/hardikpandya/stop-slop) de Hardik Pandya (MIT), que me
ajudou a formalizar a ideia para o português. As regras derivam do meu ruleset próprio
(papo-reto), não do `vale-signs-of-ai-writing` em inglês, pra manter a licença MIT
limpa.

## Licença

MIT. Ver [LICENSE](LICENSE).

Este README passou na própria régua. Roda `vale README.md` e confere.
