# Dataset: gororoba (Camada 1)

O dataset é o moat. Qualquer um refaz o regex da Camada 2 num sábado. Ninguém refaz
um dataset pt-BR de slop anotado por dois humanos com kappa de Cohen publicado. É isto
que tira a ferramenta do achismo: dá pra dizer, com número, quanto o linter concorda
com o julgamento humano.

## Status

**Coletado. Piloto validado, pronto pra anotação em escala.**

- **Piloto: passou.** Renan + Lírios calibraram a régua dos três eixos em 15 trechos.
  Kappa de Cohen na rodada final: conectivo 0,80, voz-passiva 1,00, clichê 0,81 (os três
  em "concordância quase perfeita"). Evidência crua e o histórico das três rodadas em
  `dataset/piloto/rodadas/`.
- **Dataset de validação: 113 trechos coletados**, scores em branco pra anotação humana.
  Toda linha registra a fonte; nada inventado.
  - Geradas (50): 20 `ia-sem-voz`, 15 `traducao-automatica`, 15 `ia-bem-promptada`.
  - Humanas reais (63): 21 `humano-com-voz`, 16 `humano-formal-legitimo`, 26
    `humano-simples-regional`. Fontes: ASSIN/NILC e CORAA v1.1 (que reúne C-ORAL-BRASIL,
    SP2010, ALIP) via Hugging Face, e NURC/Recife (PDF público da UFAL).
  - O regional cobre quatro pontos reais: Recife, Minas Gerais, São Paulo capital e São
    Paulo interior. Falta sul, centro-oeste e norte (as transcrições só apareceram em
    PDF-imagem ou fonte fechada); expansão geográfica fica pra v0.1.
  - Nota de balanço: hoje pende pro não-slop (78 não-slop x 35 slop), de propósito, já
    que o anteparo anti-viés é o ponto que mais precisa de cobertura. Dá pra gerar mais
    slop se a anotação pedir equilíbrio.

Meta v0: 100 a 150 trechos, balanceados em 6 classes de origem. O `seo-generico` saiu da
v0 (o piloto mostrou que, junto do clichê, derruba a concordância) e vira eixo próprio na
v0.2; a regra fica em `deferred/Hype.yml`. Plano de sourcing em `docs/plano-coleta.md`;
guia de rótulo em `docs/guia-anotacao.md`.

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
