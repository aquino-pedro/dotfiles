# ================================================
# Plugins
# ================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "Updating ${dir:t}..."
    git -C "$dir" pull --ff-only
  done
}

_zplugin_load zdharma-continuum fast-syntax-highlighting

# Custom colors matching the waybar palette (style.css)
typeset -A FAST_HIGHLIGHT_STYLES
FAST_HIGHLIGHT_STYLES[comment]='fg=#71717A'              # dark-5
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=#E35149,bold'   # vermelho (urgent)
FAST_HIGHLIGHT_STYLES[command]='fg=#42FF9F'              # verde (media)
FAST_HIGHLIGHT_STYLES[builtin]='fg=#42FF9F'
FAST_HIGHLIGHT_STYLES[alias]='fg=#42FF9F'
FAST_HIGHLIGHT_STYLES[path]='fg=#75F1FA'                 # highlight (ciano)
FAST_HIGHLIGHT_STYLES[path-to-dir]='fg=#75F1FA,underline'
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#75F1FA'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#75F1FA'

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode

