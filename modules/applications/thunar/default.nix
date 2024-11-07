{ config, pkgs, lib, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "thunar";
  };

  config = lib.mkIf (config.thunar.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        xfce.thunar
        xfce.thunar-volman
      ];
    };
  };
}
