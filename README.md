<p align="center">
  <img src="assets/hero.png" alt="Uma feijoada verde e estragada virando uma feijoada bonita e apetitosa, em pixel art" width="820">
</p>

<h1 align="center">gororoba</h1>

<p align="center">
  Linter de voz pro português brasileiro. Aponta onde teu texto virou gororoba, igual o ESLint aponta erro no código.
</p>

<p align="center">
  <a href="https://github.com/renanburn/gororoba/actions/workflows/vale.yml"><img src="https://github.com/renanburn/gororoba/actions/workflows/vale.yml/badge.svg" alt="CI Vale"></a>
  <img src="https://img.shields.io/badge/licen%C3%A7a-MIT-blue" alt="Licença MIT">
  <img src="https://img.shields.io/badge/voz-pt--BR-009c3b" alt="pt-BR">
  <img src="https://img.shields.io/badge/roda%20sobre-Vale-f9a825" alt="Roda sobre o Vale">
</p>

---

**gororoba** é gíria pra comida feita sem cuidado: sobra requentada, mistura sem gosto, rango que ninguém quer no prato. É o nome certo pro texto que ninguém quer ler: genérico, requentado, traduzido no muque, sem tempero.

Esta ferramenta prova o teu texto e mostra onde ele virou gororoba, trecho por trecho. Aí você tempera e serve melhor. Não dá nota, não acusa ninguém: aponta o ponto exato e o porquê, pra você decidir.

**Não detecta autoria de IA.** Ela diz "isto tem 3 conectivos de tradução e 2 de voz passiva", não "isto foi escrito por máquina".

## Veja rodando

<p align="center">
  <img src="assets/demo.gif" alt="No terminal, o gororoba aponta os trechos requentados de um texto e a fala brasileira passa limpa" width="760">
</p>

## Antes e depois

O mesmo recado, primeiro requentado, depois temperado. Entra gororoba:

```text
Vale ressaltar que a reunião foi produtiva. Nesse sentido, foi observado um
avanço. Ótima pergunta sobre os próximos passos.
```

Sai com voz:

```text
A reunião rendeu. A gente avançou no período. Boa pergunta: vamos aos próximos
passos.
```

O gororoba acende os quatro tells (dois conectivos de tradução, uma voz passiva, um
clichê de abertura). Você corta e serve melhor.

## O que é, e o que não é

Os detectores de autoria de IA (GPTZero, Turnitin AI) têm viés comprovado contra quem
escreve simples ou não é nativo, e foram desligados por várias universidades. gororoba
foge disso de propósito. A pergunta aqui é "vale a pena ler?", não "quem escreveu?".
Genericidade é medível e acionável. Autoria não é.

Slop é propriedade do texto, não de quem segurou o teclado. Tem IA bem usada que sai
limpa, e tem gente escrevendo gororoba pura sem máquina nenhuma.

## Roda em 3 linhas

```bash
brew install vale
git clone https://github.com/renanburn/gororoba && cd gororoba
vale tests/gororoba.md
```

Saída:

```
[conectivo-traducao] 'vale ressaltar que': conectivo de tradução.
[voz-passiva] 'foi observado': voz passiva ou impessoal.
[cliche-ia] 'Ótima pergunta': clichê de IA. Corta.
```

## Os 3 eixos da v0

| Eixo | O que pega |
|---|---|
| `conectivo-traducao` | `vale ressaltar`, `nesse sentido`, `em suma`, `ademais` |
| `voz-passiva` | `foi observado`, `pode-se notar`, gerundismo de call center |
| `cliche-ia` | `ótima pergunta`, abertura de garganta limpa, travessão como recurso, paralelismo negativo |

Ritmo, brasilidade e densidade ficam para depois. São subjetivos e baixam a
concordância entre anotadores. A v0 fica nos 3 eixos objetivos.

## O anteparo que importa

O viés que derrubou os detectores foi penalizar voz simples. gororoba corre o risco
oposto: marcar mineirês ou fala popular como slop. Isso seria a morte da ferramenta.
O fixture `tests/voz-limpa.md` existe pra travar isso: "Cê viu esse trem? Tá doido."
passa limpo, sem um alerta, junto com fala de treze cantos do Brasil. Roda e confere:

```bash
vale tests/voz-limpa.md
```

## Estado honesto

Esta é a Camada 2, o linter. Funciona e roda em CI hoje. A Camada 1, o dataset público
anotado por dois humanos com concordância (kappa) medida, ainda está em construção. Sem
ela, isto é uma régua útil; com ela, vira uma régua provada. Não vou chamar de
"benchmark" antes de ter o kappa na mão.

## Para o cético

Abre o capô. O [posicionamento](docs/POSICIONAMENTO.md) responde de frente "isso é só
regex?", "e os falsos positivos?", "pega fala popular?" e "por que confiar sem o kappa?".
O documento [a régua](docs/a-regua.md) explica o porquê de cada eixo ser slop, e o que a
régua de propósito não pega.

## Contribuir

Um linter melhora em conjunto. O [guia de contribuição](CONTRIBUTING.md) traz a regra
dura: regra nova entra com fixture (caso que deve pegar) e anti-fixture (caso que NÃO
pode pegar). Tem template de issue pra falso-positivo e pra regra nova. Sabe falar de um
canto do Brasil que ainda não está no teste? Esse é o melhor primeiro PR daqui.

## Crédito

Vem da minha régua anti-slop, que eu já mantinha antes, e do
[stop-slop](https://github.com/hardikpandya/stop-slop) de Hardik Pandya (MIT), que me
ajudou a formalizar a ideia para o português. As regras derivam do meu ruleset próprio
(papo-reto), não do `vale-signs-of-ai-writing` em inglês, pra manter a licença MIT
limpa.

## Licença

MIT. Ver [LICENSE](LICENSE).

---

<p align="center">
  <a href="https://instagram.com/renan1rg"><img src="https://img.shields.io/badge/Instagram-@renan1rg-E4405F?logo=instagram&logoColor=white" alt="Instagram"></a>
  <a href="https://1rg.com.br"><img src="https://img.shields.io/badge/site-1rg.com.br-111111" alt="Site"></a>
</p>

<p align="center">
  Mantido por Renan Guaceroni. O gororoba nasceu da régua de voz que uso no TomOS, meu sistema pessoal de IA. Esta é a parte que dá pra você levar pra casa.
</p>

<p align="center">
  <sub>Este README passou na própria régua. Roda <code>vale README.md</code> e confere.</sub>
</p>
