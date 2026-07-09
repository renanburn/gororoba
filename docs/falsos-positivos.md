# Onde a régua erra de propósito

Toda régua de voz erra em algum canto. A pergunta boa não é "erra?", é "erra onde, e por
quê?". Este doc assume, eixo por eixo, os falsos positivos conhecidos e os limites
deliberados do gororoba. Quem for cético com razão encontra aqui o mapa do que ficou de
fora, e por que ficou.

Duas categorias diferentes moram nesta lista. Uma é o limite deliberado: a régua decidiu
não pegar aquilo, com um porquê defensável. A outra é o falso positivo residual: caso em
que a régua ainda pode acender em voz legítima, mesmo com a trava do `tests/voz-limpa.md`
no lugar. As duas aparecem juntas abaixo, eixo por eixo.

## Conectivo de tradução

A régua marca só a muleta de abertura redundante (`vale ressaltar que`, `nesse sentido`):
a frase que aquece antes de dizer qualquer coisa. Coesivo culto de registro formal, como
`dessa forma`, `em suma` e `diante do exposto`, saiu da lista de propósito. Textos
jurídicos, acadêmicos e institucionais usam esses conectivos há décadas, antes de qualquer
IA existir. Marcar isso seria confundir registro formal com tradução robótica, o mesmo
viés que derrubou os detectores de autoria por acusar não nativos de fraude.

Efeito prático: um texto de petição ou parecer carregado desses conectivos passa limpo no
eixo 1. É escopo, não falha. O `tests/voz-limpa.md` trava um bloco inteiro de registro
formal exatamente pra provar isso todo dia.

## Voz passiva

Este eixo é blocklist de fórmula impessoal e burocrática (`foi observado`, `pode-se
notar`, `constata-se que`), não um parser de sintaxe. A régua não disseca a frase pra saber
se o sujeito está oculto: bate numa lista fechada de praxes de relatório.

Duas consequências, uma em cada direção:

- **Falso positivo baixo, quase zero.** Como é lista fechada, a régua raramente acende
  fora do alvo. Passiva legítima de agente desconhecido, tipo "o corpo foi encontrado" ou
  "a lei foi sancionada em 1988", não está na lista, então nem tem como acender.
- **Falso negativo assumido.** A mesma lista fechada deixa passar qualquer fórmula
  impessoal que não esteja catalogada. Um texto pode estar cheio de burocratês passivo
  fora dessas expressões exatas e sair limpo. É o preço de não fingir que a régua entende
  gramática: ela caça a praxe conhecida, não julga a frase inteira.

## Alusão vaga

Apelo a autoridade sem nome (`estudos mostram`, `especialistas afirmam`, `uma grande
marca`) é o eixo com falso positivo mais alto do gororoba, e a régua já nasceu sabendo
disso. Às vezes não dá pra nomear a fonte mesmo: contrato de NDA, sigilo de fonte
jornalística, cláusula de confidencialidade. Nesses casos, dizer "uma empresa do setor
farmacêutico nos contratou" é limite real de quem escreve, não fuga.

Por isso este eixo é `suggestion`, não `warning`: o nível mais baixo da régua, sinaliza sem
travar texto. O corte não é "tem link?", é "dava pra nomear e não nomeou?". "A Fiocruz
mediu, não achei o paper" passa limpo porque nomeia a fonte mesmo sem link. "Estudos
mostram" acende porque nem tenta.

## Gerundismo

A régua troca só as fórmulas fixas de call center (`vou estar enviando` → `envio`, `vou
estar ligando` → `ligo`). O futuro contínuo legítimo, tipo "amanhã vou estar em casa" ou
"semana que vem vou estar viajando", não acende de propósito: é gramática correta, não
praxe de SAC. A lista de swap é fechada e literal, então qualquer variação de tempo verbal
ou pessoa fora dela passa batido. É o mesmo padrão do eixo de voz passiva: precisão em
troca de cobertura.

## Paralelismo negativo

O molde "não é X, é Y" é `suggestion`, nunca `warning`, porque contraste retórico legítimo
existe e é ferramenta de escrita de verdade, não só bordão de IA. A frase:

```text
Não é sorte, é trabalho.
```

pode ser um bordão requentado ou pode ser exatamente o que alguém quer dizer numa virada de
frase pontual. A régua não distingue as duas coisas: sinaliza pra revisão humana decidir,
não bloqueia a construção.

## Travessão

O eixo pega travessão usado como recurso de estilo, o maneirismo de parágrafo que abre uma
ideia no meio da frase pra parecer mais elegante. Travessão gramatical em diálogo, marca de
fala direta como:

```text
— Vem cá, disse ela.
```

não é o alvo da regra da casa (sem travessão como recurso; use vírgula ou dois pontos), mas
o token da regra é literal: qualquer travessão acende, inclusive o de discurso direto.
Quem escreve ficção ou reportagem com diálogo marcado por esse sinal vai ver o linter
acender ali. É `suggestion`, revisão humana filtra.

## O que fica de fora, sem cobertura nenhuma

A v0 mede frase a frase. Repetição de molde no documento inteiro (seis frases boas no
mesmo esqueleto, tríade atrás de tríade, todo parágrafo fechando com tapa na mesa) não
aparece em nenhum eixo hoje. Cada frase sozinha passa limpo; juntas, formam padrão que só
se vê olhando o texto inteiro. Fica registrado como limite da v0, não como falso positivo.

## Achou a régua acendendo em fala legítima?

É o bug mais grave que este projeto pode ter. Um linter de voz que atropela voz de
verdade virou o problema que jurou resolver. Abre uma issue de falso positivo com o
template
[`.github/ISSUE_TEMPLATE/falso-positivo.yml`](../.github/ISSUE_TEMPLATE/falso-positivo.yml):
cola o trecho exato, a regra que disparou, e o motivo. Quanto mais preciso o relato, mais
rápido o trecho vira anti-fixture em `tests/voz-limpa.md` e para de vazar pra sempre.
