{ config, pkgs, lib, ... }:

{
  options = {
    spotify.enable = lib.mkEnableOption "spotify";
  };

  config = lib.mkIf (config.spotify.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        spotify
      ];
    };
  };
}
