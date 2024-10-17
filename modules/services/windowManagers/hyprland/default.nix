{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf (config.hyprland.enable) {
    home-manager.users.${config.user} = {
      xdg.configFile.hyprland = {
        source = ./hyprland.conf;
        target = "./hypr/hyprland.conf";
      };
      xdg.portal.wlr.enable = true;
      programs.sway.enable = true;
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      home.packages = with pkgs; [
        waybar
        wofi
      ];
    };
  };
}
