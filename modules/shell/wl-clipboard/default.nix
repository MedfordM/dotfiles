{ config, pkgs, lib, ... }:

{
  options = {
    wl-clipboard.enable = lib.mkEnableOption "wl-clipboard";
  };

  config = lib.mkIf (config.wl-clipboard.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        wl-clipboard
      ];
    };
  };
}
