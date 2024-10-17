{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.zellijConfig = {
      source = (if config.layout == "QWERTY" then
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

    home.packages = [
      pkgs.zellij
    ];
  };
}
