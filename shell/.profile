#!/bin/bash
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "$SSH_CONNECTION" ] && [ "$IS_SSH" != "true" ]; then
  source ~/.xinitrc
fi

source $HOME/Source/scripts/gcloud-functions.sh

export TERM="xterm-kitty"
export TRACING_ENABLED=false
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/zookeeper/bin:$PATH"
export PATH="$HOME/Source/s5-cli/main/bin:$PATH"
export PATH=/home/mike/.local/bin/oci:$PATH
export EDITOR=nvim
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export THEME=mocha
export CLOUDSDK_PYTHON_SITEPACKAGES=1
export SDKMAN_DIR="$HOME/.sdkman"
export PYENV_ROOT="$HOME/.pyenv"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

alias ls="exa -1 --git --icons --group-directories-first"
alias lsa="ls -a"
alias lst="exa -1 -D --tree -D --level=2 --icons"
alias grep='grep -i --color=auto'
alias k="kubectl"
alias gpu="git pull upstream main"
alias gru="git rebase upstream/main"

# Select a layout and create a new session
alias zl='zellij -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)'
# Select a layout and open a new tab in the current session
alias zt='zellij action new-tab -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)'

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
[[ -e "/home/mike/.local/lib/oracle-cli/lib/python3.12/site-packages/oci_cli/bin/oci_autocomplete.sh" ]] && source "/home/mike/.local/lib/oracle-cli/lib/python3.12/site-packages/oci_cli/bin/oci_autocomplete.sh"

eval "$(s5data completion zsh)"
eval "$(s5auth completion zsh)"

source /usr/share/nvm/init-nvm.sh
source $HOME/.sdkman/bin/sdkman-init.sh
source /etc/profile.d/google-cloud-cli.sh
