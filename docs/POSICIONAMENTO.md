# Posicionamento: o que o cético pergunta

Este arquivo existe pra uma coisa: aguentar a auditoria de um dev que abre o capô
desconfiado e sai respeitando, ou pelo menos sem chacota. As perguntas abaixo são as
que ele faz. As respostas trazem o estado real do projeto, não promessa.

## "Isso é só um monte de regex?"

Boa parte da Camada 2 é, sim. Os 7 arquivos em `styles/Gororoba/` são regras Vale:
listas de tokens e dois padrões com expressão regular (paralelismo negativo e
gerundismo). Não escondo isso. O valor não está em fingir sofisticação que não tem.
Está em duas coisas que o regex sozinho não dá:

1. O recorte. A lista de tells foi escolhida pra pegar slop sem pegar voz. Qualquer um
   escreve regex num sábado. O trabalho é decidir o que entra e o que fica de fora sem
   virar uma ferramenta que pune quem escreve simples.
2. O anteparo de teste. `tests/voz-limpa.md` trava o regex pra ele não vazar pra cima
   de mineirês e fala popular. Sem esse teste, o regex seria perigoso. Com ele, vira
   uma régua que você roda no seu CI.

A Camada 1, o dataset anotado, é o que tira o projeto do "é regex" pro "é regex com
concordância humana medida". Ainda está em construção. Ver "por que confiar sem o
kappa" abaixo.

## "E os falsos positivos?"

Existem, e o projeto trata eles como o risco principal, não como detalhe. Três defesas:

- Os níveis de severidade. Travessão e paralelismo negativo são `suggestion`, não
  `error`. O linter sugere, não reprova. Você decide.
- O fixture anti-viés. `tests/voz-limpa.md` é um texto de voz real (mineirês, fala
  falada, frase curta) que tem que passar com zero alerta. O CI quebra se algum tell
  vazar pra cima dele. Roda `bash tests/run.sh` e confere.
- O canal de reporte. Tem um template de issue só pra falso-positivo. Marcou voz
  legítima como slop? Abre lá. O caso vira anti-fixture e entra no teste pra não voltar.

Falso positivo aqui funciona como o jeito de a régua melhorar, em vez de ser um bug
isolado. Cada um vira um caso de teste.

## "Pega fala popular, regionalismo, gíria?"

Não, e isso é deliberado. Marcar mineirês ou fala popular como slop seria a morte da
ferramenta. "Cê viu o trem que o sô falou, uai" passa limpo. A prova não é discurso, é
o fixture `tests/voz-limpa.md`, que tem justo esse tipo de frase e roda no CI com zero
alerta. Se um dia vazar, o teste fica vermelho e o lançamento trava.

## "Isso não é mais um detector de IA com viés?"

Não. É o contrário, e a diferença é o ponto inteiro do projeto.

Os detectores de autoria (GPTZero, Turnitin AI) respondem "quem escreveu?". Erram
contra quem escreve simples e contra quem não é nativo, a ponto de universidades
desligarem eles. O gororoba responde outra pergunta: "este texto tem tell de slop?".
Slop é propriedade do texto, medível e acionável. Autoria não é.

Consequência prática: IA bem usada sai limpa aqui, e humano escrevendo genérico leva
alerta. A ferramenta não tenta adivinhar a máquina. Ela aponta o trecho e mostra qual
regra disparou, pra você corrigir ou ignorar.

## "Por que confiar nisso sem o kappa ainda?"

Não confie como benchmark. Eu não chamo de benchmark, justamente porque o kappa não
está medido. O que está pronto e roda hoje é a Camada 2: o linter, os 7 eixos, o CI
verde, os dois fixtures. Isso é uma régua útil, testável, que você roda no seu texto
agora.

O que falta é a Camada 1: 100 a 150 trechos pt-BR anotados por dois humanos com o kappa
de Cohen publicado por eixo, incluindo o eixo mais fraco. Enquanto esse número não
existe, o projeto é uma régua honesta, não uma régua provada. O plano de coleta
(`docs/plano-coleta.md`), o guia de anotação (`docs/guia-anotacao.md`) e o script que
calcula o kappa (`scripts/kappa.py`, com auto-teste) já estão no repo. Dá pra auditar o
método antes de o dado existir.

Resumo do estado, sem maquiagem:

| Camada | O que é | Estado |
|---|---|---|
| Camada 2 | o linter Vale, 7 eixos, CI | pronto, roda hoje |
| Camada 1 | dataset anotado + kappa por eixo | em construção, 0 trechos |

## "De onde vem isso? É original?"

Não é originalidade total, e não finjo que é. As regras vêm da minha régua anti-slop
(papo-reto), que eu já mantinha, e do
[stop-slop](https://github.com/hardikpandya/stop-slop) de Hardik Pandya (MIT), que me
ajudou a formalizar a ideia pro português. As regras derivam do meu ruleset, não do
`vale-signs-of-ai-writing` em inglês, pra manter a licença MIT limpa. O crédito está no
README e na licença.
