{ config, pkgs, lib, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "thunar";
  };

  config = lib.mkIf (config.thunar.enable) {
    environment.systemPackages = with pkgs; [
      gvfs
    ];
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
