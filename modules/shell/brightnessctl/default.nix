{ config, lib, pkgs, ... }:

{
  options = {
    brightnessctl.enable = lib.mkEnableOption "brightnessctl";
  };

  config = lib.mkIf config.brightnessctl.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        brightnessctl
      ];
    };
  };
}
