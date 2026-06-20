#!/usr/bin/env bash
# Valida o ruleset: o fixture sujo tem que acusar, o limpo tem que passar.
set -u
cd "$(dirname "$0")/.."

fail=0

count() { vale --output=JSON "$1" 2>/dev/null | python3 -c 'import sys,json; d=json.load(sys.stdin); print(sum(len(v) for v in d.values()))'; }

sujo=$(count tests/gororoba.md)
limpo=$(count tests/voz-limpa.md)
readme=$(count README.md)

echo "tests/gororoba.md  -> $sujo alertas (espera > 0)"
echo "tests/voz-limpa.md -> $limpo alertas (espera 0)"
echo "README.md          -> $readme alertas (espera 0, passa na própria régua)"

[ "$sujo" -gt 0 ]  || { echo "FALHA: gororoba.md devia acusar"; fail=1; }
[ "$limpo" -eq 0 ] || { echo "FALHA: voz-limpa.md devia passar limpo (anteparo anti-viés)"; fail=1; }
[ "$readme" -eq 0 ] || { echo "FALHA: README.md devia passar na própria régua"; fail=1; }

[ "$fail" -eq 0 ] && echo "OK: ruleset validado." || echo "ruleset com falha."
exit $fail
