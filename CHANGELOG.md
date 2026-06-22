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
- Camada de publicação e comunidade: `docs/POSICIONAMENTO.md` (FAQ do cético),
  `CONTRIBUTING.md` (regra dura fixture + anti-fixture), `CODE_OF_CONDUCT.md`,
  templates de issue (falso-positivo, regra-nova) e de PR, `index.md` + `_config.yml`
  pra GitHub Pages (sem ativar enquanto o repo for privado).
- `tests/run.sh` agora trava os docs de prosa pública na própria régua (README, index,
  CONTRIBUTING, CODE_OF_CONDUCT, POSICIONAMENTO: zero alerta cada).
