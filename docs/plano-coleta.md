# Plano de coleta: gororoba (Camada 1)

Como juntar 100 a 150 trechos pt-BR balanceados nas 7 classes de origem. Pequeno mas
real, no modelo de rigor do ASSIN (NILC/USP): poucos exemplos, anotação cuidada.

**Status (2026-06-22):** o piloto passou (kappa dos 3 eixos em `dataset/piloto/rodadas/`).
As classes geradas já entraram na planilha-mãe: 20 `ia-sem-voz`, 15 `traducao-automatica`,
15 `ia-bem-promptada` (50 trechos, scores em branco). Falta a parte humana (`humano-com-voz`,
`humano-formal-legitimo`, `humano-simples-regional`), que depende de coleta de fonte real,
detalhada mais abaixo. O `seo-generico` saiu da v0 (vai pra v0.2).

## Meta por classe (alvo: ~120 trechos)

A meta força o balanceamento. Slop e não-slop ficam quase meio a meio de propósito,
porque o dataset precisa provar que a régua não confunde formal/regional com gororoba.

| Classe | É gororoba? | Meta | Origem do material |
|---|---|---|---|
| `humano-com-voz` | não | 20 | corpora de fala/escrita viva + textos autorais conhecidos |
| `humano-formal-legitimo` | não | 15 | acórdãos, normas técnicas, papers (formal de verdade) |
| `humano-simples-regional` | não | 20 | fala popular, mineirês, transcrição oral (anteparo anti-viés) |
| `ia-sem-voz` | sim | 20 | geração LLM com prompt raso, sem direção de voz |
| `ia-bem-promptada` | não/baixo | 15 | geração LLM com prompt de voz forte (papo-reto) |
| `traducao-automatica` | sim | 15 | inglês vertido por MT sem revisão (translationese) |
| `seo-generico` | sim | 15 | artigos de blog de SEO de baixo esforço |
| | | **120** | (folga até 150 pra reforçar classe fraca pós-piloto) |

## Humano-natural: corpora a usar

Antes de buscar qualquer coisa, consultar o catálogo
[`ajdavidl/Portuguese-NLP`](https://github.com/ajdavidl/Portuguese-NLP) (mapa dos
recursos pt-BR; evita reinventar a busca). Fontes citadas no design doc:

- **Carolina Corpus (USP)**: corpus geral contemporâneo amplo. Bom pra
  `humano-com-voz` e parte de `humano-formal-legitimo`. Cuidar de licença por tipologia
  ao extrair trecho.
- **NILC (USP)**: recursos e corpora pt-BR de referência. Fonte de material formal e
  de apoio.
- **ASSIN / ASSIN2** ([nilc-nlp/assin2](https://huggingface.co/datasets/nilc-nlp/assin2)):
  pares de sentenças cuidadas. Serve de material humano e de **modelo metodológico**
  (split fixo, kappa, data card).
- Para `humano-simples-regional`: transcrição de fala (corpora orais do catálogo),
  legendas/entrevistas regionais, material de fala popular. Aqui o cuidado é máximo: é
  o anteparo. Trechos curtos com gíria, dialeto, mineirês.

Critério de extração: trecho de 1 a 4 frases, autossuficiente, sem dado pessoal
identificável. Registrar a `fonte` exata (corpus + id/URL) em toda linha.

## Slop e SEO: como gerar/coletar

- **`ia-sem-voz`**: gerar com LLM, prompt deliberadamente raso ("escreva um parágrafo
  sobre X"), sem nenhuma instrução de voz. É o caso central. Anotar na `fonte` o modelo
  e o prompt usado, pra reprodutibilidade.
- **`ia-bem-promptada`**: gerar com o mesmo LLM mas com prompt de voz forte (a régua
  papo-reto, ou pedido explícito de português falado, direto, sem clichê). Prova que
  IA bem usada sai limpa. Mesmo registro de modelo+prompt na `fonte`.
- **`traducao-automatica`**: pegar texto fonte em inglês e verter por tradutor
  automático sem revisão humana. O alvo é o translationese, o "soa traduzido". Registrar
  a fonte em inglês e o tradutor.
- **`seo-generico`**: coletar de artigos de blog de SEO de baixo esforço (os de
  "10 dicas para...", introdução de garganta limpa, encheção). Trecho curto,
  representativo da genericidade industrial. Registrar a URL.

## Equilíbrio e blindagem do viés

- Não deixar uma classe dominar. Se a anotação-piloto mostrar uma classe fraca ou
  ambígua, a folga até 150 vai pra reforçar essa classe, não pra inchar a fácil.
- Os trechos `humano-simples-regional` e `humano-formal-legitimo` são o teste de fogo:
  se a régua marcar eles como gororoba, ou tem erro de anotação ou tem viés exposto. Os
  dois resultados são publicáveis.
- Anonimizar antes de versionar. Sem dado pessoal, sem trecho que identifique alguém.

## Ordem de trabalho

1. Ler o catálogo `ajdavidl/Portuguese-NLP` e mapear o que serve.
2. Coletar/gerar o material por classe até a meta, preenchendo `trecho`, `fonte`,
   `classe_origem` na planilha-mãe (`dataset/anotacao.csv`), scores em branco.
3. Rodada-piloto de 15 (guia de anotação), mede kappa, calibra.
4. Anotação em escala, duas cópias independentes.
5. Kappa por eixo, consolidação, publicação.
