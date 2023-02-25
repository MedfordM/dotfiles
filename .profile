# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/Source/scripts/start-ssh-agent.sh
# Add maven to path
M2_HOME='/opt/apache-maven-3.8.6'
PATH="$M2_HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
export PATH
export MAVEN_OPTS="-Dconfig.file=$HOME/Source/darwin/localFiles/local.conf"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Misc/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Misc/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Misc/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Misc/google-cloud-sdk/completion.zsh.inc"; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
