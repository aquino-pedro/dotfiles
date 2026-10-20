# ================================================
# History
# ================================================
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# ================================================
# Kitty behaviour - close
# ================================================
if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
	export KITTY_SHELL_INTEGRATION="enabled"
	autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
	kitty-integration
	unfunction kitty-integration
fi


# ================================================
# Shell behaviour
# ================================================

setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT  # sort file10 after file9, not after file1

# ================================================
# Smart directory navigation
# ================================================

# Initialize zoxide
eval "$(zoxide init zsh)"

# ================================================
# completion
# ================================================

# load completion system
autoload -Uz compinit

# initialize completion with cached metadata file
compinit -d "$XDG_CONFIG_HOME/zsh/zcompdump"

# enable interactive completion menu selection
zstyle ':completion:*' menu select

# make completion case-insensitive
# example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' #lowercase input

# ================================================
# Fuzzy finder
# ================================================

if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
fi

# ================================================
# Modular Config Files
# ================================================

# fzf configuration
source "$ZDOTDIR/fzf.zsh"

# Aliases
source "$ZDOTDIR/aliases.zsh"

# Custom keybindings
source "$ZDOTDIR/bindings.zsh"

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# Prompt/theme
source "$ZDOTDIR/prompt.zsh"

fastfetch
