{ lib, xdg, home, pkgs, ... }:

{
  home.packages = [
    pkgs.zellij
  ];

  xdg.configFile.zellijConfig = {
    source = ./config.kdl;
    target = "./zellij/config.kdl";
  };

  xdg.configFile.zellijLayouts = {
    source = ./layouts;
    target = "./zellij/layouts";
  };
}
