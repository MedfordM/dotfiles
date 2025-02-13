#!/bin/bash
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "$SSH_CONNECTION" ] && [ "$IS_SSH" != "true" ]; then
  source ~/.xinitrc
fi

source $HOME/Source/scripts/gcloud-functions.sh

export TERM="xterm-kitty"
export TRACING_ENABLED=false
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/zookeeper/bin:$PATH"
export EDITOR=nvim
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export THEME=mocha
export CLOUDSDK_PYTHON_SITEPACKAGES=1

alias ls="exa -1 --git --icons --group-directories-first"
alias lst="exa -1 -D --tree -D --level=2 --icons"
alias grep='grep -i --color=auto'
alias k="kubectl"

# Select a layout and create a new session
alias zl='zellij -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)'
# Select a layout and open a new tab in the current session
alias zt='zellij action new-tab -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)'

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source /usr/share/nvm/init-nvm.sh
source $HOME/.sdkman/bin/sdkman-init.sh
source /etc/profile.d/google-cloud-cli.sh
