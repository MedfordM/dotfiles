{ lib, xdg, home, pkgs, ... }:

{
  home.packages = [
    pkgs.zellij
  ];

  xdg.configFile.zellijConfig = {
    source = (if pkgs.stdenv.isDarwin then
        ./config_qwerty.kdl
      else
        ./config.kdl
    );
    target = "./zellij/config.kdl";
  };

  xdg.configFile.zellijLayouts = {
    source = ./layouts;
    target = "./zellij/layouts";
  };
}
