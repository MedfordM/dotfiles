autoload -U compinit; compinit

ZSH_THEME="powerlevel10k/powerlevel10k"
COMPLETION_WAITING_DOTS="true"

plugins=(
	docker
	docker-compose
	fzf
	gcloud
	git
	mvn
	node
	npm
	nvm
	#zsh-interactive-cd
	fzf-tab
	zsh-256color
	#zsh-autosuggestions
)

zstyle ':fzf-tab:complete:*' fzf-min-height 40
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons --git --group-directories-first $realpath'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/Source/scripts/alias.sh

