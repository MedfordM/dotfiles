autoload -U compinit; compinit
bindkey -v

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

source <(fzf --zsh)
bindkey -v "\e[H" beginning-of-line
bindkey -v "\e[F" end-of-line
bindkey -v "\e[A" up-line-or-beginning-search
bindkey -v "\e[B" down-line-or-beginning-search

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-min-height '20'

eval "$(starship init zsh)"

setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups

eval "$(zoxide init --cmd cd zsh)"

source $HOME/.profile
