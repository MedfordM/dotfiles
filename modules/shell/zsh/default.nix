{ config, ... }:

{
  config = {
    home-manager.users.${config.user} = {
      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = true;
        history = {
          path = "$ZDOTDIR/.zsh_history";
          share = true;
          size = 99999;
          append = true;
          expireDuplicatesFirst = true;
          ignoreDups = true;
        };
        initExtra = ''
          autoload -U up-line-or-beginning-search
          autoload -U down-line-or-beginning-search
          zle -N up-line-or-beginning-search
          zle -N down-line-or-beginning-search

          bindkey -e "\e[H" beginning-of-line
          bindkey -e "\e[F" end-of-line
          bindkey -e "\e[A" up-line-or-beginning-search
          bindkey -e "\e[B" down-line-or-beginning-search

          zstyle ':completion:*:git-checkout:*' sort false
          zstyle ':completion:*:descriptions' format '[%d]'
          '';
      };
    };
  };
}
