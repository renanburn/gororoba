# Piloto de anotação: resultado (rodada 3)

Dois anotadores (Renan e Lírios), 15 trechos, três eixos, escala 0/1/2. Cada um pontuou
sozinho, sem ver a nota do outro. O número abaixo é o kappa de Cohen por eixo, medido
**antes** de qualquer conversa sobre os desacordos. Os dois CSVs crus estão nesta pasta
(`anotacao-renan.csv`, `anotacao-lirios.csv`); qualquer um refaz a conta com
`scripts/kappa.py`.

## Kappa por eixo (rodada 3)

| Eixo | Kappa de Cohen | Concordância exata |
|---|---|---|
| conectivo-de-tradução | 0,80 | 14/15 |
| voz-passiva | 1,00 | 15/15 |
| clichê-IA | 0,81 | 14/15 |

Pela escala de Landis e Koch, 0,80 ou mais é "concordância quase perfeita". Os três
eixos cruzaram essa linha.

## Como chegou aqui (três rodadas)

A régua não nasceu pronta. Falhou, o desacordo apontou onde, a causa certa foi
corrigida a cada vez, e o kappa subiu por mérito.

| Eixo | Rodada 1 | Rodada 2 | Rodada 3 |
|---|---|---|---|
| conectivo | 0,24 | 0,37 | **0,80** |
| voz-passiva | 0,00 | 0,71 | **1,00** |
| clichê | −0,05 | 0,86 | **0,81** |

- **Rodada 1 → 2:** a anotadora nova ainda não reconhecia o slop de IA e marcava fala
  regional como robô. Correção: rodada de calibração de 15 minutos lendo os exemplos
  juntos, mais a interface passando a abrir os exemplos por padrão.
- **Rodada 2 → 3:** sobrou o conectivo, porque os bordões traduzidos ("no fim do dia",
  "deixa eu ser honesto") ficavam na fronteira entre dois eixos. Correção: cravar que
  bordão de conversa traduzido é clichê (eixo 3), e o eixo 1 fica só com o conectivo
  formal de redação. Documentado em `docs/guia-anotacao.md`.

## Honestidade de escopo

Isto é o piloto: 15 trechos de calibração. Prova que a régua dos três eixos é
reproduzível entre dois humanos e que os anotadores estão alinhados. **Não é** o kappa
do dataset de validação (100 a 150 trechos), que é o número que vai pro README do
projeto como benchmark. O piloto destrava a anotação em escala; ele não a substitui.
