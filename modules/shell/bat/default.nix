{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.bat = {
      source = ./.;
    };

    home.packages = [
      pkgs.bat
    ];
  };
}
