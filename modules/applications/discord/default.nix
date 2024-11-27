{ config, lib, pkgs, ... }:

{
  options = {
    discord.enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf (config.discord.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        discord
      ];
    };
  };
}
