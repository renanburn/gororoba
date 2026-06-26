#!/usr/bin/env bash
# Varre a rede de forks e mostra os que estão à frente do main, pra pescar
# contribuição perdida e convidar um PR. Não mescla nada: aprendizado é humano.
# Precisa do gh autenticado. Uso: bash scripts/scan-forks.sh [owner/repo]
set -euo pipefail
REPO="${1:-renanburn/gororoba}"

echo "Forks de $REPO à frente do main:"
echo

gh api "repos/$REPO/forks" --paginate \
  --jq '.[] | [.owner.login, .default_branch] | @tsv' |
while IFS=$'\t' read -r owner branch; do
  ahead=$(gh api "repos/$REPO/compare/main...${owner}:${branch}" \
            --jq '.ahead_by' 2>/dev/null || echo 0)
  if [ "${ahead:-0}" -gt 0 ] 2>/dev/null; then
    echo "  ${owner} (+${ahead} commits)"
    echo "    https://github.com/$REPO/compare/main...${owner}:${branch}"
  fi
done

echo
echo "Olhe os diffs. Se prestar, convide um PR. Nada entra sem o par fixture + anti-fixture."
