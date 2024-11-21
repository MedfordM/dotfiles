{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      tree-sitter
    ];
    xdg.configFile.nvim = {
      source = ../../../config/nvim;
    };
  };
}
