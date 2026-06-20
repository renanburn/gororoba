# Changelog

## v0.1.0 (não lançado)

Primeira versão da Camada 2 (o linter). A Camada 1 (dataset anotado + kappa) ainda
está em construção.

- Ruleset Vale com 3 eixos: conectivo-de-tradução, voz passiva, clichê de IA.
- 7 regras: Conectivos, VozPassiva, Cliches, Aberturas, Travessao,
  ParalelismoNegativo, Gerundismo.
- Regras derivadas do papo-reto (fork MIT do stop-slop), não do ruleset inglês,
  para manter a licença limpa.
- Fixtures de teste: `tests/gororoba.md` (acusa) e `tests/voz-limpa.md` (passa limpo,
  inclui mineirês como anteparo anti-viés).
- CI com Vale via GitHub Actions.
