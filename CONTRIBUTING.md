# Como contribuir com o gororoba

Um linter de voz só fica bom em conjunto. Cada pessoa que escreve em pt-BR conhece um
tell de slop que eu não conheço, e cada uma conhece um jeito de falar legítimo que o
linter não pode atropelar. Esta página diz como propor regra, como reportar erro e como
ajudar a construir o dataset.

## A regra dura: par fixture + anti-fixture

Toda regra nova proposta precisa vir com os dois:

- **fixture**: um caso que a regra DEVE pegar. O slop que você quer caçar.
- **anti-fixture**: um caso parecido que a regra NÃO pode pegar. Voz legítima,
  mineirês, fala popular, formal correto. O caso que prova que a regra não vaza.

PR sem os dois não entra. Sem reclamação, sem exceção. O anti-fixture é o que separa
este projeto de um detector de IA com viés. Uma regra que pega slop mas também pega
"cê viu o trem, sô" é uma regra ruim, e o anti-fixture é o que expõe isso antes do
merge.

Onde colocar:

- o fixture vai pra `tests/gororoba.md` (texto que deve acusar);
- o anti-fixture vai pra `tests/voz-limpa.md` (texto que deve passar limpo).

O `tests/run.sh` checa os dois: o sujo tem que ter alerta, o limpo tem que ter zero.

## Rodar o Vale local

```bash
brew install vale       # ou ver instalação em vale.sh/install
git clone https://github.com/renanburn/gororoba && cd gororoba
vale tests/gororoba.md  # vê o linter acusando
vale tests/voz-limpa.md # vê o linter passando limpo
bash tests/run.sh       # roda a validação inteira (o que o CI roda)
```

Se `bash tests/run.sh` terminar com "OK: ruleset validado.", está verde.

## Propor uma regra nova

1. Abre uma issue do tipo "regra-nova" antes do PR, descrevendo o padrão de slop e em
   qual dos 3 eixos ele cai (`conectivo-traducao`, `voz-passiva`, `cliche-ia`).
2. Escolhe o eixo certo. Os arquivos de regra ficam em `styles/Gororoba/`. Quase tudo é
   `extends: existence` com uma lista de `tokens`. Adiciona teu tell na regra do eixo,
   ou cria um arquivo novo se for um sub-padrão distinto.
3. Pensa na severidade. `error` é pra clichê de IA puro, que não tem defesa. `warning`
   é pro que quase sempre é slop mas tem exceção. `suggestion` é pro que depende de
   contexto (travessão, paralelismo negativo). Na dúvida, sobe pra `suggestion`: o
   linter sugere, não reprova.
4. Adiciona o fixture e o anti-fixture (a regra dura).
5. Roda `bash tests/run.sh`. Tem que passar.
6. Abre o PR e preenche o template, que cobra o par fixture + anti-fixture.

Critério de aceite de uma regra: ela pega slop real e não toca voz legítima. Se o teu
anti-fixture for fraco (não cobre o caso de voz que mais se parece com o teu slop), eu
vou pedir um mais duro antes do merge.

## Reportar um falso-positivo

Marcou voz legítima como slop? Esse é o bug mais grave que o projeto pode ter. Abre uma
issue do tipo "falso-positivo" com o trecho exato e qual regra disparou (`vale --output=line teu-arquivo.md`
mostra a regra). O trecho vira anti-fixture em `tests/voz-limpa.md`, a regra é ajustada
pra parar de vazar, e o teste trava pra não voltar.

## Contribuir trecho anotado pro dataset (Camada 1)

A Camada 1 é o dataset pt-BR de slop anotado por humanos, com kappa de Cohen. É o moat
do projeto e está em construção (0 trechos). Como ajudar:

1. Lê `docs/plano-coleta.md` (de onde vem o material, balanceado em 7 classes de origem)
   e `docs/guia-anotacao.md` (como rotular, a escala 0/1/2, a política de desacordo).
2. Pra contribuir trecho cru: trecho de 1 a 4 frases, autossuficiente, sem dado pessoal,
   com a `fonte` exata registrada e a `classe_origem` marcada. Os scores ficam em branco
   (a anotação é feita por dois humanos independentes).
3. Pra contribuir anotação: a anotação vale quando é feita por dois anotadores
   independentes e o kappa é medido com `scripts/kappa.py`. Anotação solo não entra no
   conjunto de validação, porque o número que importa é a concordância entre duas
   cabeças, não o palpite de uma.

O kappa publicado é sempre o de antes da conversa de consenso. Inflar o kappa mata o
moat, então não fazemos isso.

## Voz dos textos do projeto

A ironia do projeto: ele detecta o próprio slop. Todo `.md` que você adicionar deve
passar na régua. Roda `vale teu-arquivo.md` e limpa os alertas que caírem fora de bloco
de exemplo. Tells citados dentro de tabela de definição ou de bloco de exemplo são
esperados (o fixture mostra a doença sem estar doente). Tell na prosa corrida é pra
limpar.

## Código de conduta

Participar do projeto implica seguir o [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).
