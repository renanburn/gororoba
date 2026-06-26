# Guia de anotação: prosódia (eixo v0.3, rascunho)

Uma página. Lê antes de tocar no CSV. Este eixo entra **depois** dos 113 fecharem
nos três eixos atuais, com piloto próprio. Não é medir som bonito. É medir **defeito
sonoro ou rítmico não intencional em prosa que queria ser neutra**.

## O anteparo (lê isto antes de qualquer coisa)

Prosódia é o eixo mais perigoso da régua. Ritmo, rima, aliteração e repetição são
ferramenta em texto expressivo, não doença. Rap rima de propósito. Repente e cordel
são feitos de métrica. Letra, poesia, slogan e fala viva jogam com som por ofício.
Nada disso é gororoba.

Regra dura, acima de todas as outras deste eixo: som trabalhado de propósito, em
registro expressivo, oral, poético ou publicitário, é **prosódia 0, sempre.** O alvo é
só o tropeço involuntário em prosa que tentava ser limpa e tropeçou. Na dúvida entre
defeito e escolha do autor, é escolha. Prosódia a gente prova, não presume.

Se um trecho `humano-com-voz`, `humano-simples-regional` ou de origem poética levar
prosódia alta, ou é erro de anotação ou é achado sobre o viés. Os dois interessam,
nenhum vira régua sem investigação.

## O que você está rotulando

Um score novo, `prosodia_score`, por trecho, independente dos outros três. Um texto
pode ter conectivo 0, voz passiva 0 e prosódia 2. Você rotula pelo que o ouvido tropeça
na leitura em voz alta, não pela origem.

## Os 4 sinais do eixo

### 1. cacófato
Som ruim ou palavra acidental que nasce na emenda de duas palavras. Vício de linguagem
clássico da gramática normativa. Só conta quando é involuntário e atrapalha. Trocadilho
de propósito não entra.

- Pega: "por cada" (porcada), "boca dela" (cadela), "vou-me já" (vomejá), "nunca gostei
  dela" (cadela), "uma mão nela".
- Não pega: trocadilho de propósito, gíria, nome próprio. Som que o autor quis.
- Exemplo 2 (forte): *"Ela deu um beijo na boca dela e saiu por cada porta."*
- Exemplo 0 (ausente): *"Ela beijou a Ana e saiu pela porta dos fundos."*

### 2. eco / rima involuntária
Rima ou repetição de terminação onde o texto não pedia rima. O som martelado de
sufixos iguais em fila. O caso mais comum e mais fácil de medir: cadeia de `-ção`,
`-mente`, `-dade`, `-ável`.

- Pega: "a criação da solução trouxe a sensação de evolução", "rapidamente, claramente,
  o time agiu corretamente".
- Não pega: rima de propósito (verso, refrão, slogan), repetição retórica deliberada
  (anáfora), termo técnico sem sinônimo.
- Exemplo 2 (forte): *"A implementação da automação gerou a otimização da operação."*
- Exemplo 0 (ausente): *"A gente automatizou o processo e ele ficou mais rápido."*

### 3. monotonia de cadência
Toda frase do mesmo tamanho e da mesma forma, lado a lado, sem respiro. É o sinal
mensurável do eixo: na régua final vira número, o desvio-padrão do comprimento das
frases, com a estilometria dando o limiar (variância baixa, abaixo de ~3 palavras, é
cadência robótica; variação saudável fica acima de ~8). Na anotação humana, você marca
pelo embolo: leu três, quatro frases e todas batem no mesmo compasso.

- Pega: blocos de frases curtas idênticas em fila, ou de frases longas todas com a mesma
  estrutura sujeito-verbo-objeto.
- Não pega: frase curta isolada pra dar ênfase. Lista, que é monótona de propósito.
  Texto que varia tamanho e ritmo.
- Exemplo 2 (forte): *"O projeto começou bem. A equipe trabalhou junto. O cliente
  aprovou tudo. O prazo foi cumprido. O resultado ficou ótimo."*
- Exemplo 0 (ausente): *"Deu certo. O cliente, que vinha cético desde a primeira reunião
  e quase largou no meio do caminho, aprovou na hora. Alívio geral."*

### 4. colisão sonora
Choque de vogais arrastado (hiato duro) ou aliteração acidental que tropeça a leitura.
De novo: só o não intencional.

- Pega: "ia à área agora", aliteração sem querer ("o sucesso do processo sossegou a
  sessão").
- Não pega: aliteração de propósito (verso, jingle, título), hiato natural que não
  atrapalha.
- Exemplo 2 (forte): *"O acesso ao processo sucessivo cessou."*
- Exemplo 0 (ausente): *"Travaram o acesso e o processo parou."*

## A escala (0 / 1 / 2)

| Score | Significa | Critério |
|---|---|---|
| **0** | ausente | nenhum sinal, ou som trabalhado de propósito (registro expressivo, poético, oral) |
| **1** | presente leve | um tropeço isolado que não domina o trecho |
| **2** | presente forte | dois ou mais sinais, ou um que define o tom (o ouvido para nele) |

Regra de bolso: na dúvida entre dois níveis, escolhe o menor. Na dúvida entre defeito e
escolha do autor, é escolha (score 0). Mesma lógica dos outros eixos: cortar o que puxa
o kappa pra baixo.

## Relação com `classe_origem`

A classe não decide o score, mas aqui ela é o termômetro do viés mais que nos outros
eixos. Espera-se que `humano-simples-regional` e origens com pegada oral ou poética
tenham som mais marcado, e isso **não pode** virar prosódia alta. Se virar, o sinal está
vazando pra cima de voz viva, que é o erro que mata o moat. O cruzamento origem x
prosódia é o que prova que a régua pega tropeço de prosa morta, não musicalidade de
gente que sabe escrever.

## Por que isso não vira regra Vale pura (honestidade técnica)

Cacófato e cadência precisam de silabação e escansão, e o Vale puro não escanseia nem
conta tônica. Então a sequência é: anota humano, mede kappa, e só o sinal que passar no
kappa vira sinal de verdade. Na implementação, o eco entra como regex de sufixo (o Vale
faz), mas cacófato, cadência e colisão entram via passo auxiliar de escansão (referência
aberta pra pt-BR: Aoidos, Poemetrizador), alimentando o Vale. O número de cadência fica
determinístico (mesma entrada, mesma variância), e preserva a reprodutibilidade que é a
âncora do projeto. Nada de modelo, nada de "aprendeu o que é bonito".

## Política de resolução de desacordo

Idêntica à do guia principal: os dois anotam independente, mede o kappa de Cohen da
prosódia **antes** de qualquer conversa, esse é o número que vai pro repo, e só depois
abre os desacordos. Caso de borda que não fecha vira `disputado` na coluna `notas` e sai
da validação, documentado, não apagado. O kappa publicado é o de antes da conversa.

## Rodada-piloto própria (faz isto primeiro)

Prosódia tem o **seu** piloto de 15 trechos, cobrindo as 7 classes de origem, com peso
extra nas classes oral, regional e poética, que é onde o sinal vaza. Mede o kappa desses
15 por sinal. Se o anteparo furar (musicalidade de propósito levando score), senta, lê o
desacordo, aperta a definição aqui no guia antes de soltar a escala. A prosódia só entra
na régua pública se passar o mesmo corte que validou os três primeiros eixos.

---

## Nota sobre a régua neste guia

Como no [`guia-anotacao.md`](guia-anotacao.md), os alertas que o `vale` acusa neste
arquivo caem todos dentro das definições e dos blocos de exemplo, onde os sinais estão
citados de propósito pra ensinar. A prosa fora de exemplo passa limpa. Este guia fica
**fora** da checagem do `run.sh` pelo mesmo motivo que o guia-mãe: cita sinais fora de
bloco de código, igual o fixture sujo.
