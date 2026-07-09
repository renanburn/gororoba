#!/usr/bin/env bash
# gororoba: instalador de 1 linha.
# curl -fsSL https://raw.githubusercontent.com/renanburn/gororoba/main/scripts/instalar.sh | bash
#
# Sem sudo, sem brew: baixa o vale (versão pinada) e a régua pra ~/.gororoba,
# e deixa um wrapper `gororoba` pronto em ~/.local/bin. Rodar de novo atualiza
# a régua (idempotente).
set -euo pipefail

VALE_VERSION="3.15.1"
GROROBA_HOME="$HOME/.gororoba"
BIN_DIR="$GROROBA_HOME/bin"
LOCAL_BIN="$HOME/.local/bin"
REPO_TARBALL="https://github.com/renanburn/gororoba/archive/refs/heads/main.tar.gz"

log() { printf 'gororoba: %s\n' "$1"; }
erro() { printf 'gororoba: %s\n' "$1" >&2; exit 1; }

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# --- detecta SO e arquitetura ---------------------------------------------

os_raw="$(uname -s)"
case "$os_raw" in
  Darwin) vale_os="macOS" ;;
  Linux)  vale_os="Linux" ;;
  *) erro "SO '$os_raw' não suportado. Só macOS e Linux por enquanto." ;;
esac

arch_raw="$(uname -m)"
case "$arch_raw" in
  x86_64|amd64)   vale_arch="64-bit" ;;
  arm64|aarch64)  vale_arch="arm64" ;;
  *) erro "arquitetura '$arch_raw' não suportada. Só x86_64 e arm64 por enquanto." ;;
esac

mkdir -p "$BIN_DIR" "$LOCAL_BIN"

# --- vale: usa o do PATH se já existir, senão baixa ------------------------

if command -v vale >/dev/null 2>&1; then
  log "achei o vale no seu PATH ($(command -v vale)), pulo o download."
elif [ -x "$BIN_DIR/vale" ]; then
  log "vale já baixado em $BIN_DIR/vale, pulo o download."
else
  asset="vale_${VALE_VERSION}_${vale_os}_${vale_arch}.tar.gz"
  url="https://github.com/errata-ai/vale/releases/download/v${VALE_VERSION}/${asset}"
  log "baixando o vale $VALE_VERSION ($vale_os/$vale_arch)..."
  curl -fsSL "$url" -o "$TMP_DIR/vale.tar.gz" \
    || erro "não consegui baixar $url. Confere sua conexão e tenta de novo."
  tar -xzf "$TMP_DIR/vale.tar.gz" -C "$TMP_DIR" vale
  mv "$TMP_DIR/vale" "$BIN_DIR/vale"
  chmod +x "$BIN_DIR/vale"
  log "vale instalado em $BIN_DIR/vale."
fi

# --- régua: baixa o repo e extrai só .vale.ini + styles/ -------------------

log "puxando a régua..."
curl -fsSL "$REPO_TARBALL" -o "$TMP_DIR/gororoba.tar.gz" \
  || erro "não consegui baixar a régua em $REPO_TARBALL."
tar -xzf "$TMP_DIR/gororoba.tar.gz" -C "$TMP_DIR"

repo_dir="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d -name 'gororoba-*')"
[ -n "$repo_dir" ] || erro "não achei a pasta do repo no tarball baixado."

rm -rf "$GROROBA_HOME/styles"
cp "$repo_dir/.vale.ini" "$GROROBA_HOME/.vale.ini"
cp -R "$repo_dir/styles" "$GROROBA_HOME/styles"

# StylesPath do .vale.ini copiado vira caminho absoluto, pra rodar de
# qualquer cwd (o original é relativo, feito pra rodar de dentro do repo).
tmp_ini="$TMP_DIR/.vale.ini"
sed "s#^StylesPath = styles#StylesPath = $GROROBA_HOME/styles#" \
  "$GROROBA_HOME/.vale.ini" > "$tmp_ini"
mv "$tmp_ini" "$GROROBA_HOME/.vale.ini"

log "régua atualizada em $GROROBA_HOME."

# --- wrapper -----------------------------------------------------------

wrapper="$LOCAL_BIN/gororoba"
cat > "$wrapper" <<'WRAPPER_EOF'
#!/usr/bin/env bash
# gororoba: wrapper do vale já com a régua carregada.
# Sem argumento, lê o stdin como markdown. Com argumento, passa pro vale.
set -euo pipefail

GROROBA_HOME="$HOME/.gororoba"
CONFIG="$GROROBA_HOME/.vale.ini"

if [ -x "$GROROBA_HOME/bin/vale" ]; then
  VALE_BIN="$GROROBA_HOME/bin/vale"
elif command -v vale >/dev/null 2>&1; then
  VALE_BIN="$(command -v vale)"
else
  echo "gororoba: não achei o vale. Roda o instalador de novo:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/renanburn/gororoba/main/scripts/instalar.sh | bash" >&2
  exit 1
fi

if [ ! -f "$CONFIG" ]; then
  echo "gororoba: régua não instalada em $CONFIG. Roda o instalador de novo." >&2
  exit 1
fi

if [ "$#" -eq 0 ]; then
  exec "$VALE_BIN" --config "$CONFIG" --ext=.md
else
  exec "$VALE_BIN" --config "$CONFIG" "$@"
fi
WRAPPER_EOF
chmod +x "$wrapper"

log "wrapper pronto em $wrapper."

# --- PATH --------------------------------------------------------------

case ":$PATH:" in
  *":$LOCAL_BIN:"*) ;;
  *)
    log "$LOCAL_BIN não está no seu PATH. Adiciona essa linha no seu shell"
    log "(~/.zshrc ou ~/.bashrc) e abre um terminal novo:"
    log "  export PATH=\"$LOCAL_BIN:\$PATH\""
    ;;
esac

log "pronto. Testa com: gororoba caminho/do/arquivo.md"
