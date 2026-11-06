#!/bin/zsh
# --- Pager -------------------------------------------------------------------

export PAGER=moor
export MOOR="--style=catppuccin-mocha"
export BAT_PAGER="moor --no-linenumbers --quit-if-one-screen"
export BAT_STYLE="numbers,changes,header"

# --- Aliases -----------------------------------------------------------------

alias ls='eza --group-directories-first'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree --level=2'

# --- History -----------------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY HIST_IGNORE_DUPS INC_APPEND_HISTORY

# --- Completion --------------------------------------------------------------

fpath=("/opt/homebrew/share/zsh-completions" "/opt/homebrew/share/zsh/site-functions" $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# --- Prompt ------------------------------------------------------------------

eval "$(starship init zsh)"

# --- Plugins -----------------------------------------------------------------

export FZF_CTRL_R_OPTS="--height=40% --layout=reverse --border"
source <(fzf --zsh)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
