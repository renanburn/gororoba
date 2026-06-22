#!/usr/bin/env bash
# Valida o ruleset: o fixture sujo tem que acusar, o limpo tem que passar.
set -u
cd "$(dirname "$0")/.."

fail=0

count() { vale --output=JSON "$1" 2>/dev/null | python3 -c 'import sys,json; d=json.load(sys.stdin); print(sum(len(v) for v in d.values()))'; }

sujo=$(count tests/gororoba.md)
limpo=$(count tests/voz-limpa.md)

echo "tests/gororoba.md  -> $sujo alertas (espera > 0)"
echo "tests/voz-limpa.md -> $limpo alertas (espera 0)"

[ "$sujo" -gt 0 ]  || { echo "FALHA: gororoba.md devia acusar"; fail=1; }
[ "$limpo" -eq 0 ] || { echo "FALHA: voz-limpa.md devia passar limpo (anteparo anti-viés)"; fail=1; }

# Docs de prosa que dizem passar na própria régua. Cada um tem que ter zero alerta.
# (guia-anotacao.md e plano-coleta.md ficam de fora: citam tells dentro de exemplos
#  de propósito, como o fixture sujo.)
for doc in README.md index.md CONTRIBUTING.md CODE_OF_CONDUCT.md docs/POSICIONAMENTO.md; do
  n=$(count "$doc")
  echo "$doc -> $n alertas (espera 0, passa na própria régua)"
  [ "$n" -eq 0 ] || { echo "FALHA: $doc devia passar na própria régua"; fail=1; }
done

[ "$fail" -eq 0 ] && echo "OK: ruleset validado." || echo "ruleset com falha."
exit $fail
