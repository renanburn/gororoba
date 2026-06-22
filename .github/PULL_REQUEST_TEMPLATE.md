<!-- Lê o CONTRIBUTING.md antes de abrir. A regra dura está lá. -->

## O que este PR faz

<!-- Uma ou duas frases. Direto. -->

## Tipo

- [ ] Regra nova ou ajuste de regra
- [ ] Correção de falso-positivo
- [ ] Trecho ou anotação pro dataset (Camada 1)
- [ ] Doc, CI, ou outro

## A regra dura: par fixture + anti-fixture

Obrigatório pra qualquer PR que mexe em regra. PR sem os dois não entra.

- [ ] **fixture** adicionado em `tests/gororoba.md`: o caso que a regra DEVE pegar.
- [ ] **anti-fixture** adicionado em `tests/voz-limpa.md`: o caso parecido que a regra
      NÃO pode pegar (voz legítima, mineirês, fala popular, formal correto).

Cola aqui o fixture e o anti-fixture que você adicionou:

```
fixture (deve acusar):

anti-fixture (deve passar limpo):
```

## Checagem

- [ ] Rodei `bash tests/run.sh` e terminou com "OK: ruleset validado.".
- [ ] Os `.md` que adicionei ou alterei passam na própria régua (`vale arquivo.md`),
      fora dos blocos de exemplo.
- [ ] Escolhi a severidade certa (`error` só pra clichê de IA sem defesa; `suggestion`
      pro que depende de contexto).
