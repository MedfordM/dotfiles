#!/bin/bash
if [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ -z "$SSH_CONNECTION" ] && [ "$IS_SSH" != "true" ]; then
  source ~/.xinitrc
fi

source $HOME/Source/scripts/alias.sh
source $HOME/Source/scripts/fzf.sh

export XDG_CONFIG_HOME="$HOME/.config"
export GCM_CREDENTIAL_STORE="gpg"
export GCM_GPG_PATH="/usr/bin/gpg2"
export NVM_DIR="$HOME/.nvm"
export SDKMAN_DIR="$HOME/.sdkman"
export TERM="xterm-kitty"
export XDG_CACHE_HOME="$HOME/.cache"
export TRACING_ENABLED=false
export M2_HOME='/opt/apache-maven-3.8.6'
export PATH="$M2_HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"
export MAVEN_OPTS="-Dconfig.file=$HOME/Source/darwin/localFiles/local.conf"
export EDITOR=nvim
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8
export MANPAGER='nvim +Man!'
export QT_QPA_PLATFORMTHEME="qt5ct"
export THEME=mocha

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
