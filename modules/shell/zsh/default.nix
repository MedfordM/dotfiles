{ config, ... }:

{
  config = {
    home-manager.users.${config.user} = {
      programs.zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = true;
        defaultKeymap = "viins";
        history = {
          path = "$ZDOTDIR/.zsh_history";
          share = true;
          size = 99999;
          append = true;
          expireDuplicatesFirst = true;
          ignoreDups = true;
        };
        initExtraFirst = ''
          autoload up-line-or-beginning-search
          autoload down-line-or-beginning-search
          zle -N up-line-or-beginning-search
          zle -N down-line-or-beginning-search
          zstyle ':completion:*:git-checkout:*' sort false
          zstyle ':completion:*:descriptions' format '[%d]'
        '';
        initExtra = ''
          bindkey -M viins "\\e[H" beginning-of-line
          bindkey -M viins "\\e[F" end-of-line
          bindkey -M viins "\\e[A" up-line-or-beginning-search
          bindkey -M viins "\\e[B" down-line-or-beginning-search
          bindkey -M viins "\\eOA" up-line-or-beginning-search
          bindkey -M viins "\\eOB" down-line-or-beginning-search
          bindkey -M vicmd h vi-backward-char
          bindkey -M vicmd n down-line
          bindkey -M vicmd e up-line
          bindkey -M vicmd i vi-forward-char
        '';
      };
    };
  };
}
