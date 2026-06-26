#!/usr/bin/env bash
# Valida o ruleset: o fixture sujo tem que acusar, o limpo tem que passar.
set -u
cd "$(dirname "$0")/.."

fail=0

# Conta alertas de um arquivo. Algumas versões do Vale imprimem stdout vazio quando
# o arquivo passa limpo, em vez de "{}"; tratamos vazio como zero alerta.
count() { vale --output=JSON "$1" 2>/dev/null | python3 -c 'import sys,json; s=sys.stdin.read().strip(); d=json.loads(s) if s else {}; print(sum(len(v) for v in d.values()))'; }

sujo=$(count tests/gororoba.md)
limpo=$(count tests/voz-limpa.md)

echo "tests/gororoba.md  -> $sujo alertas (espera > 0)"
echo "tests/voz-limpa.md -> $limpo alertas (espera 0)"

[ "$sujo" -gt 0 ]  || { echo "FALHA: gororoba.md devia acusar"; fail=1; }
[ "$limpo" -eq 0 ] || { echo "FALHA: voz-limpa.md devia passar limpo (anteparo anti-viés)"; fail=1; }

# Docs de prosa que dizem passar na própria régua. Cada um tem que ter zero alerta.
# (guia-anotacao.md e plano-coleta.md ficam de fora: citam tells em exemplos fora de
#  bloco de código, como o fixture sujo. usar-com-ia.md entra: cita os tells dentro do
#  bloco do prompt, que o Vale ignora, então a prosa tem que passar limpa.)
for doc in README.md index.md CONTRIBUTING.md CODE_OF_CONDUCT.md docs/POSICIONAMENTO.md AGENTS.md docs/usar-com-ia.md; do
  n=$(count "$doc")
  echo "$doc -> $n alertas (espera 0, passa na própria régua)"
  [ "$n" -eq 0 ] || { echo "FALHA: $doc devia passar na própria régua"; fail=1; }
done

[ "$fail" -eq 0 ] && echo "OK: ruleset validado." || echo "ruleset com falha."
exit $fail
