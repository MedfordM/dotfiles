{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.starship = {
      source = ../../../config/starship/starship.toml;
      target = "./starship.toml";
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
