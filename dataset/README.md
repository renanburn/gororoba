# Dataset: gororoba (Camada 1)

O dataset é o moat. Qualquer um refaz o regex da Camada 2 num sábado. Ninguém refaz
um dataset pt-BR de slop anotado por dois humanos com kappa de Cohen publicado. É isto
que tira a ferramenta do achismo: dá pra dizer, com número, quanto o linter concorda
com o julgamento humano.

## Status

**Em construção. 0 trechos anotados.** A planilha tem só o cabeçalho. A anotação é
trabalho humano (Renan + 1) e ainda não começou. O plano de sourcing está em
`docs/plano-coleta.md`; o guia de rótulo, em `docs/guia-anotacao.md`.

Meta v0: 100 a 150 trechos, balanceados nas 7 classes de origem.

## Estrutura

```
dataset/
  README.md        (este arquivo)
  anotacao.csv     (planilha-mãe: cabeçalho + trechos, ainda sem score)
```

Cópias de anotação (uma por anotador) NÃO vivem aqui versionadas durante a anotação.
Cada anotador trabalha numa cópia local (ex: `anotacao-renan.csv`,
`anotacao-b.csv`), fora do controle de versão até medir o kappa. Só o consolidado
final entra no repo.

## Formato do CSV

UTF-8, vírgula como separador, primeira linha é o cabeçalho. Colunas:

| Coluna | O que é |
|---|---|
| `id` | identificador único do trecho (ex: `001`, `002`). Estável: nunca reusa. |
| `trecho` | o texto a rotular. Aspas duplas se tiver vírgula dentro. |
| `fonte` | de onde veio (corpus, URL, "gerado: prompt X"). Rastreabilidade. |
| `classe_origem` | uma das 7 classes (ver guia). Procedência, não score. |
| `conectivo_score` | eixo conectivo-de-tradução: 0 / 1 / 2 |
| `vozpassiva_score` | eixo voz-passiva: 0 / 1 / 2 |
| `cliche_score` | eixo clichê-IA: 0 / 1 / 2 |
| `anotador` | quem rotulou esta linha (ex: `renan`, `b`). |
| `notas` | observação livre: `disputado`, justificativa de borda, etc. |

A escala 0/1/2 e o significado de cada classe estão definidos em
`docs/guia-anotacao.md`. Não duplica aqui pra não divergir.

## Como dois anotadores trabalham

1. Parte da planilha-mãe (`anotacao.csv`), que tem os trechos e as classes mas os
   scores em branco.
2. Cada anotador duplica pra sua cópia local e preenche os três scores **sem ver a
   cópia do outro**. Independência é o que faz o kappa valer.
3. Roda `python3 scripts/kappa.py anotacao-renan.csv anotacao-b.csv` pra medir a
   concordância por eixo. Esse número é o que vai pro README do projeto, incluindo o
   eixo mais fraco. Expor o ponto fraco é o que converte cético em fã.
4. Só depois das duas cópias prontas e do kappa medido, abre os desacordos e fecha o
   rótulo de consenso (política em `docs/guia-anotacao.md`). O kappa publicado é o de
   **antes** do consenso.

Antes da anotação em escala, faz a rodada-piloto de 15 trechos descrita no guia.
