{ xdg, home, pkgs, ... }:

{
  xdg.configFile.nvim = {
    source = ./.;
  };

  home.packages = [
    pkgs.neovim
  ];
}
