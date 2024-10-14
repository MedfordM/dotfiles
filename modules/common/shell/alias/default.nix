{ config, home-manager, home, ... }:

{
    home.shellAliases = {
      grep = "grep -i --color=auto";
      ls = "exa -1 --git --icons --group-directories-first";
      lst = "exa -1 -D --tree -D --level=2 --icons";
      k = "kubectl";
      zl="zellij -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)";
      zt="zellij action new-tab -l $(fd --format='{/.}' --base-directory=$HOME/.config/zellij/layouts | fzf)";
    };
}
