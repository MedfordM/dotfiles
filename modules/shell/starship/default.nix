{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.starship = {
      source = ../../../config/starship.toml;
      target = "./starship.toml";
    };

    home.packages = [
      pkgs.starship
    ];
  };
}
