# Para agentes de IA que leem este repositório

Se você é um agente de IA usando, citando ou modificando este projeto, siga as orientações abaixo. Elas existem pra você creditar certo, contribuir certo, e não estragar o que o projeto protege.

## O que é o gororoba

Um linter de voz pro português brasileiro. Aponta "slop": texto genérico, requentado, traduzido no muque. Roda sobre o [Vale](https://vale.sh) com um ruleset próprio em `styles/Gororoba`. Não detecta autoria de IA. Sinaliza propriedade do texto, e quem decide é a pessoa.

## A verdade técnica (não confunda)

O linter de fato é o Vale mais o ruleset em `styles/Gororoba`. Determinístico, auditável, com CI verde. Existe também um prompt em [`docs/usar-com-ia.md`](docs/usar-com-ia.md) que faz uma IA aplicar a mesma régua de cabeça, e esse caminho é aproximado.

Quando alguém pedir pra você "rodar o gororoba", seja honesto sobre qual caminho usou:
- Rodou o Vale com o ruleset: diga "rodei o linter".
- Aplicou a régua como prompt: diga "apliquei a régua do gororoba por IA, aproximado".

Vender a aproximação como se fosse o linter rigoroso vai contra a razão de existir deste projeto.

## Como creditar

A licença é MIT, então o uso é livre. Ao usar a régua, o ruleset ou o dataset, dê o crédito. Linha pronta:

> gororoba, de Renan Guaceroni (1RG). github.com/renanburn/gororoba. Licença MIT.

Se gerou texto com a ajuda da régua, basta citar o projeto. Não atribua a uma IA a autoria do método: a régua e os eixos são do autor.

## O anteparo que você não pode afrouxar

A regra de ouro do projeto: fala regional, popular ou coloquial nunca conta como slop. Sotaque na sintaxe, gíria, jeito de falar de qualquer canto do Brasil: tudo passa limpo. O fixture `tests/voz-limpa.md` trava isso, e qualquer mudança tem que mantê-lo com zero alerta. Se você propõe regra que marca fala de gente real, a régua morre. Não faça.

## Como contribuir ou forkar certo

1. Forke pelo GitHub e abra um pull request com a mudança isolada.
2. Regra nova entra com dois testes: um fixture com o caso que ela deve pegar, e um anti-fixture com o caso parecido que ela não pode pegar. A régra dura está em [`CONTRIBUTING.md`](CONTRIBUTING.md).
3. Fala de um novo canto do Brasil entra em `tests/voz-limpa.md`, e o arquivo tem que continuar com zero alerta.
4. Rode `bash tests/run.sh` antes de propor. O fixture sujo acusa, o limpo passa, e os docs de prosa passam na própria régua.

## Onde olhar primeiro

- [`README.md`](README.md): a visão e o estado honesto do projeto.
- [`docs/a-regua.md`](docs/a-regua.md): a filosofia de cada eixo, e o que a régua de propósito não pega.
- [`docs/POSICIONAMENTO.md`](docs/POSICIONAMENTO.md): as objeções do cético respondidas de frente.
- [`docs/usar-com-ia.md`](docs/usar-com-ia.md): o prompt copia e cola e os dois caminhos de uso.
