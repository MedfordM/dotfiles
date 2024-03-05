autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

typeset -g -A key

if [[ -n "$KITTY_INSTALLATION_DIR" ]]; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -e -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -e -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -e -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -e -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -e -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -e -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -e -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -e -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -e -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -e -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -e -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -e -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -e -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -e -- "${key[Control-Right]}" forward-word

bindkey -es "\e[9u" "\t"
# bindkey -e "\e[9u" menu-expand-or-complete
# bindkey -e "\e[9u" expand-or-complete
bindkey -e "\e[H" beginning-of-line
bindkey -e "\e[127u" backward-delete-char
bindkey -e "\e[127;5u" backward-kill-word
bindkey -e "\e[105;5u" forward-word
bindkey -e "\e[104;5u" backward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

COMPLETION_WAITING_DOTS="true"

plugins=(
	# docker
	# docker-compose
	# fzf
	# gcloud
	gitfast
	mvn
	# node
	# npm
	# nvm
	#zsh-interactive-cd
	# fzf-tab
	# zsh-256color
	#zsh-autosuggestions
)

source ~/.oh-my-zsh/oh-my-zsh.sh
source /home/mike/Source/scripts/alias.sh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

bindkey "\e[9u" fzf-completion
# bindkey -M menuselect "\e[9u" forward-word
bindkey -M menuselect "\e[9u" menu-complete
zstyle ':completion:*' file-sort modification

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/mike/.local/share/google-cloud-sdk/path.zsh.inc' ]; then . '/home/mike/.local/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/mike/.local/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/mike/.local/share/google-cloud-sdk/completion.zsh.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/mike/.sdkman"
[[ -s "/home/mike/.sdkman/bin/sdkman-init.sh" ]] && source "/home/mike/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
