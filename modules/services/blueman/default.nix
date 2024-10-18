{ config, lib, pkgs, ... }:

{
  options = {
    blueman.enable = lib.mkEnableOption "blueman";
  };

  config = lib.mkIf (config.blueman.enable) {
    services.blueman.enable = true;
    home-manager.users.${config.user} = {
      services.blueman-applet.enable = true;
    };
  };
}
