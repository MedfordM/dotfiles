{ config, pkgs, lib, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "thunar";
  };

  config = lib.mkIf (config.thunar.enable) {
    services.gvfs.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
