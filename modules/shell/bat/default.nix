{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.bat = {
      source = ../../../config/bat;
    };

    home.packages = [
      pkgs.bat
    ];
  };
}
