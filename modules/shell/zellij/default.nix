{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.zellijConfig = {
      source = (if config.layout == "QWERTY" then
          ../../../config/zellij/config_qwerty.kdl
          else
          ../../../config/zellij/config.kdl
          );
      target = "./zellij/config.kdl";
    };

    xdg.configFile.zellijLayouts = {
      source = ../../../config/zellij/layouts;
      target = "./zellij/layouts";
    };

    home.packages = [
      pkgs.zellij
    ];
  };
}
