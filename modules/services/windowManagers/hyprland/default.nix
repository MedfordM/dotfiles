{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf (config.hyprland.enable) {
    programs.sway.enable = true;
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    home-manager.users.${config.user} = {
      xdg.configFile.hyprland = {
        source = ../../../../config/hyprland/hyprland.conf;
        target = "./hypr/hyprland.conf";
      };
      home.packages = with pkgs; [
        waybar
        wofi
      ];
    };
  };
}
