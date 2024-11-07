{ config, pkgs, lib, ... }:

{
  options = {
    mission-center.enable = lib.mkEnableOption "mission-center";
  };

  config = lib.mkIf (config.mission-center.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        mission-center
      ];
    };
  };
}
