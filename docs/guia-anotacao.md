# Guia de anotação: gororoba (Camada 1)

Uma página. Lê antes de tocar no CSV. O objetivo é rotular trechos de texto pt-BR
por eixo de gororoba, com concordância medível entre dois humanos. Não é detectar
quem escreveu. É medir quanta gororoba o texto tem.

## O que você está rotulando

Cada trecho ganha um score em três eixos, mais o registro de qual classe de origem
ele é. O score é por eixo, não um veredito único. Um texto pode ter conectivo de
tradução zero e voz passiva forte. Mede cada coisa separada.

## Os 3 eixos

### 1. conectivo-de-tradução (`conectivo_score`)
Conectivo de garganta limpa que abre frase sem entregar informação. Marca de texto
vertido do inglês ou de IA que precisa de transição antes de dizer qualquer coisa.

- Pega: "vale ressaltar que", "nesse sentido", "dito isso", "em suma", "ademais",
  "outrossim", "sendo assim", "dessa forma", "diante do exposto", "com efeito".
- Não pega: conectivo que carrega sentido real ("porque", "mas", "então" numa fala
  viva). Conjunção comum não é gororoba.
- Fronteira com o clichê (decidida na rodada-piloto Renan+Lírios, 2026-06-22): este
  eixo é só o conectivo de redação formal. Bordão de conversa traduzido do inglês ("no
  fim do dia", "deixa eu ser honesto", "a milha extra", "um dia de cada vez") NÃO entra
  aqui, cai no clichê-IA (eixo 3). Sem essa regra os dois anotadores dividiam: ambos
  viam o slop, mas um marcava conectivo e o outro clichê, e o conectivo despencava.
- Exemplo 2 (forte): *"Vale ressaltar que, nesse sentido, é importante destacar..."*
- Exemplo 0 (ausente): *"O show atrasou porque choveu."*

### 2. voz-passiva (`vozpassiva_score`)
Passiva e impessoal que apaga o sujeito. Voz de relatório, de call center, de quem
não quer dizer quem fez. Inclui gerundismo ("vou estar verificando").

- Pega: "foi observado", "pode-se notar", "é possível observar", "vou estar
  enviando", excesso de "-se" impessoal.
- Não pega: passiva legítima e necessária ("a lei foi sancionada em 1988"), onde o
  agente não importa mesmo. Aqui o julgamento conta: passiva pra esconder gente é 2;
  passiva técnica correta é 0.
- Exemplo 2 (forte): *"Foi observado que o resultado pode ser melhorado."*
- Exemplo 0 (ausente): *"A gente reparou que dá pra melhorar isso."*

### 3. clichê-IA (`cliche_score`)
Frase-feita de assistente, abertura de palestra, estrutura previsível. O som de IA
sendo educada ou de blogueiro genérico. **Sentido estrito: só clichê de IA.** Hype de
propaganda/SEO ("descubra agora", "dicas infalíveis") NÃO entra aqui na v0: o piloto 2
mostrou que juntar os dois numa pergunta derruba a concordância. Propaganda vira eixo
próprio na v0.2 (regra guardada em `deferred/Hype.yml`).

- Pega: "ótima pergunta", "com certeza", "fico feliz em ajudar", "no mundo de hoje",
  "mais do que nunca", paralelismo negativo ("não é X, é Y"), regra dos três
  decorativa, travessão usado como recurso de efeito.
- **Não pega gíria nem mineirês (anteparo anti-viés, a regra mais dura do eixo).**
  "brabo", "sô", "cê", "trem", "uai", "bora", fala falada e regional são clichê 0,
  sempre. O piloto 2 mostrou que isso vaza com anotador de fora (mineirês levou 2),
  então a interface mostra os exemplos calibrados na cara do anotador, não só numa regra.
- Não pega também: ênfase real, repetição de propósito, travessão gramatical correto em
  aposto curto. O alvo é o clichê, não a pontuação em si.
- Exemplo 2 (forte): *"Ótima pergunta! No mundo de hoje, mais do que nunca..."*
- Exemplo 0 (ausente): *"Boa. A resposta curta é não."* / *"Esse trem ficou brabo, sô. Liga o som e vê."*

## A escala (0 / 1 / 2 por eixo)

| Score | Significa | Critério |
|---|---|---|
| **0** | ausente | nenhuma marca do eixo, ou só uso legítimo (passiva técnica, conjunção viva) |
| **1** | presente leve | uma marca isolada e discreta que não domina o trecho |
| **2** | presente forte | duas ou mais marcas, ou uma que define o tom do trecho |

Por que 3 níveis e não binário: binário (tem/não tem) joga fora a diferença entre
"um deslize" e "trecho encharcado", que é justo a informação que o linter precisa
calibrar. Por que não 5 níveis: granularidade maior derruba o kappa, porque dois
humanos não concordam sobre "3 vs 4" de forma estável. Três níveis é o ponto onde a
distinção é real e a concordância aguenta. É a mesma lógica do design doc: cortar o
que puxa o kappa pra baixo.

Regra de bolso: na dúvida entre dois níveis, escolhe o menor. Gororoba a gente prova,
não presume.

## As 7 classes de origem (`classe_origem`)

Registra a procedência de cada trecho. Servem pra cruzar slop com autoria de
propósito e blindar o viés. Valor do campo entre parênteses.

| Classe (valor) | É gororoba? | O que essa classe testa |
|---|---|---|
| `humano-com-voz` | não | baseline positivo: voz real tem que dar score baixo |
| `humano-formal-legitimo` | não | formal (jurídico/técnico) não é slop. Anti falso-positivo de formalidade |
| `humano-simples-regional` | não | **anteparo anti-viés. Mineirês e fala popular têm que passar limpos** |
| `ia-sem-voz` | sim | o caso central: IA genérica, o alvo da ferramenta |
| `ia-bem-promptada` | não/baixo | prova que slop ≠ autoria: IA bem usada sai limpa |
| `traducao-automatica` | sim | translationese: o "soa traduzido do inglês" |
| `seo-generico` | sim | genericidade industrial de blog de SEO |

A classe não decide o score. Você rotula o eixo pelo que está escrito, não pela
origem. O cruzamento (origem x score) é o que vai provar, depois, que a régua não
está só adivinhando autoria. Se um trecho `humano-simples-regional` levar score alto,
ou isso é um erro de anotação ou é um achado sobre o viés. Os dois interessam.

## Política de resolução de desacordo

1. Os dois anotam **independente**, sem ver a planilha do outro. Cada um na sua cópia.
2. Mede o kappa de Cohen por eixo (ver `scripts/kappa.py`) antes de qualquer conversa.
   Esse número é o que vai pro repo. Não se mexe nele depois.
3. Só então abre os desacordos. Diferença de 1 ponto (0 vs 1, 1 vs 2): conversa curta,
   fecha num valor de consenso pra coluna final. Diferença de 2 pontos (0 vs 2): caso
   de borda real, discute o porquê e, se não fechar, marca o trecho como `disputado`
   na coluna `notas` e tira ele do conjunto de validação (fica documentado, não
   apagado).
4. O kappa publicado é o de **antes** da conversa. O consenso serve pro rótulo final
   de uso, não pra inflar a concordância. Inflar o kappa mata o moat.

## Rodada-piloto (faz isto primeiro)

Antes de anotar os 100-150, os dois anotam os **mesmos 15 trechos** de aquecimento,
cobrindo as 7 classes. Mede o kappa desses 15. Se vier baixo num eixo, senta, lê os
desacordos, ajusta o entendimento do eixo (não o guia em segredo: se mudar critério,
anota a mudança aqui no guia). Só depois solta a anotação em escala. A piloto existe
pra calibrar as duas cabeças, não pra contar como dado.

---

## Nota sobre a régua neste guia

Os alertas que o `vale docs/guia-anotacao.md` acusa são todos dentro das tabelas de
definição e dos blocos de exemplo, onde as marcas estão citadas de propósito pra
ensinar o que cada eixo pega. É o mesmo papel do fixture `tests/gororoba.md`: um texto
que mostra a doença não está doente. A prosa do guia (tudo fora de exemplo) passa
limpa. Confere rodando o vale e olhando onde cada hit cai: se algum cair fora de
exemplo, é bug do guia e conserta.
