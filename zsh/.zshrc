# ==========================================
# History Configuration
# ==========================================
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=2000

setopt inc_append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space

# ==========================================
# Shell Behaviour
# ==========================================
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT # sort file10 after file9, not after file1

# =========================================================
# Completion
# =========================================================

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower


# =========================================================
# Modular Config Files
# =========================================================

# Plugins and plugin manager
source "$ZDOTDIR/plugins.zsh"

# ==========================================
# Environment Variables & Paths
# ==========================================
export PATH=$PATH:/home/bash_master/.local/bin
export PATH=/usr/local/go/bin:$PATH
export TZ='Asia/Kolkata'
export PATH=$PATH:$(go env GOPATH)/bin

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Envman
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Rust (Cargo)
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ==========================================
# Aliases
# ==========================================
alias ls='eza --icons'
alias ll='eza -l --icons --header --git --group-directories-first'
alias la='eza -la --icons --header --git --group-directories-first'
alias lg='lazygit'
alias gho='ghostty'
alias bat='batcat'
alias vi='nvim'

# Alert alias adapted for zsh
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ==========================================
# Tool Initializations
# ==========================================
# Oh-My-Posh (Zsh specific init)
eval "$(oh-my-posh init zsh --config '/home/bash_master/.poshthemes/custom_bash_master.omp.json')"

# Zoxide (Zsh specific init)
eval "$(zoxide init zsh)"

# ==========================================
# Custom Functions
# ==========================================

# Tmux wrapper function
tmux() {
    if [[ "$*" == "" ]]; then
        command tmux new-session -A -s work \; \
            popup -h 100% -w 100% -E  'tmux attach -t work'
    else
        command tmux "$@"
    fi
}

# Open file in nvim using fzf
vf() {
  local file
  file=$(fzf --preview 'batcat --color=always {}')
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
}

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    if [[ "$*" == "" ]]; then
        command tmux new-session -A -s work \; \
            popup -h 100% -w 100% -E  'tmux attach -t work'
    else
        command tmux "$@"
    fi

fi

if [[ "$TERM_PROGRAM" == "" ]]; then
    command ghostty
fi

# Tab: accept autosuggestion if one is showing, otherwise normal completion
_tab_accept_or_complete() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
  else
    zle expand-or-complete
  fi
}
zle -N _tab_accept_or_complete
bindkey '^I' _tab_accept_or_complete
