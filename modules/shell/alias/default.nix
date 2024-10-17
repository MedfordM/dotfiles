{ config,... }:

{
  home-manager.users.${config.user}.home = {
    shellAliases = {
      grep = "grep -i --color=auto";
      ls = "eza -1 --git --icons --group-directories-first";
      lst = "eza -D --tree --level=2 --icons";
      k = "kubectl";
      zl="zellij -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)";
      zt="zellij action new-tab -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)";
    };
  };
}
