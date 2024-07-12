autoload -U compinit; compinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

source <(fzf --zsh)
bindkey -e "\e[H" beginning-of-line
bindkey -e "\e[F" end-of-line
bindkey -e "\e[A" up-line-or-beginning-search
bindkey -e "\e[B" down-line-or-beginning-search

source $HOME/.local/share/fzf-tab/fzf-tab.plugin.zsh
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-min-height '20'

eval "$(starship init zsh)"

HISTFILE=$HOME/.zsh_history
SAVEHIST=9999
HISTSIZE=9999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups


eval "$(zoxide init --cmd cd zsh)"
if [ -f "$HOME/.local/share/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/share/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/.local/share/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/share/google-cloud-sdk/completion.zsh.inc"; fi

source $HOME/.profile
