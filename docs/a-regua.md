# A régua: por que cada eixo é gororoba

Este documento explica o raciocínio por trás dos três eixos. O ruleset (em `styles/`)
diz o que a régua pega; aqui está o porquê. Quem quiser propor regra nova ou discordar
de uma existente começa por aqui.

## A regra-mãe

Texto bom em português soa como alguém de verdade falando, não como artigo traduzido.

O sinal número um de texto requentado não é erro de gramática. É o contrário: gramática
limpa demais, conectivo demais, e o ritmo de quem nunca abriu a boca pra dizer aquilo. O
slop é fluente e vazio ao mesmo tempo. Por isso a pergunta da régua é "vale a pena ler?",
não "quem escreveu?". A régua persegue o que um brasileiro real não diria em voz alta.

## Os três eixos, e o que cada um persegue

### 1. Conectivo de tradução

Conectivo de garganta limpa que abre a frase sem entregar informação: "vale ressaltar
que", "nesse sentido", "dito isso", "em suma", "diante do exposto". É a muleta de quem
precisa de uma rampa antes de dizer qualquer coisa, sinal de redação de escola e de texto
vertido do inglês.

Por que é gororoba: a frase já funcionaria sem ele. Corte o conectivo e a informação
chega mais rápido e mais forte. O que carrega sentido real ("porque", "mas", "então" numa
fala viva) não cai aqui; conjunção comum não é slop. O alvo é o enfeite que adia o
conteúdo.

### 2. Voz passiva

Passiva e impessoal que apaga quem fez: "foi observado", "pode-se notar", "constata-se
que", mais o gerundismo de call center ("vou estar enviando"). É a voz de quem não quer
dizer o sujeito, de relatório que foge da responsabilidade.

Por que é gororoba: esconde o agente e esfria o texto. "Foi observado que dá pra melhorar"
vira "vi que dá pra melhorar", e aí aparece gente. A passiva legítima, onde o agente não
importa mesmo ("a lei foi sancionada em 1988"), não é alvo. O julgamento separa as duas:
passiva pra fugir de quem fez é slop, passiva técnica correta não é.

### 3. Clichê de IA

Frase pronta que todo assistente solta e bordão de conversa traduzido: "ótima pergunta",
"no mundo de hoje", "mais do que nunca", o paralelismo negativo "não é X, é Y", o
travessão usado de efeito, e o translationese tipo "no fim do dia" ou "a milha extra". É o
som da máquina sendo educada ou do blog genérico.

Por que é gororoba: é forma sem conteúdo, reconhecível à distância porque já foi lida mil
vezes. O leitor sente a fôrma. Este é o eixo mais difícil de medir, porque mora mais na
impressão do que numa lista fechada, e foi o que mais custou a calibrar entre anotadores
humanos. Por isso a fronteira é dura: bordão de conversa cai aqui, conectivo formal cai no
eixo 1.

## A trava: voz não é slop

O risco que mata uma régua dessas é o oposto do que ela caça: marcar voz simples ou fala
regional como defeito. Foi o viés que derrubou os detectores de autoria. A régua corre o
mesmo risco e se protege com uma trava dura.

Fala de gente de verdade, mesmo torta, mesmo simples, mesmo puxando pro regional, não é
gororoba. "Cê viu esse trem? Tá doido" passa limpo, sempre. Gíria, dialeto e oralidade são
voz, não ruído. Quando a dúvida é entre "está fora da regra" e "está vivo", vence o vivo.
O fixture `tests/voz-limpa.md` existe pra travar isso no automático: se a régua acender
ali, é bug dela, não defeito da fala.

## O que a régua ainda não pega

Honestidade de escopo: a v0 mede frase a frase. Tem um tipo de slop que só aparece no
documento inteiro, a repetição de molde: seis frases ótimas no mesmo esqueleto ("não é X,
é Y" três vezes, todo parágrafo fechando com tapa na mesa, tríade atrás de tríade). Cada
uma sozinha funciona; juntas viram fôrma e o leitor sente. Medir densidade de molde é
trabalho de uma versão futura, não da v0. Fica registrado pra não fingir que a régua faz o
que ainda não faz.

## De onde isto vem

Os três eixos derivam de uma régua de voz pessoal (papo-reto) que o autor já mantinha, ela
mesma inspirada no [stop-slop](https://github.com/hardikpandya/stop-slop) de Hardik Pandya
(MIT). O gororoba é a parte dessa régua que generaliza: a que mede sem reescrever, pra
qualquer um usar no próprio texto.

---

Nota: rodar `vale docs/a-regua.md` acende vários alertas. Todos caem dentro dos exemplos,
onde os sinais estão citados de propósito pra ensinar o que cada eixo pega, igual o fixture
`tests/gororoba.md`. A prosa explicativa, fora dos exemplos, passa limpa. Por isso este
doc não entra na lista de prosa travada por `tests/run.sh`.
