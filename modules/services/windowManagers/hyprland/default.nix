{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf (config.hyprland.enable) {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    home-manager.users.${config.user} = {
      services.mako = {
        enable = true;
        defaultTimeout = 3500;
      };
      xdg.configFile.hyprland = {
        source = ../../../../config/hyprland/hyprland.conf;
        target = "./hypr/hyprland.conf";
      };
      xdg.configFile.hyprlandThemes = {
        source = ../../../../config/hyprland/themes;
        target = "./hypr/themes";
      };
      home.packages = with pkgs; [
        waybar
        wofi
        hypridle
      ];
      services.hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 120;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 1800;
              on-timeout = "systemctl suspend";
            }
          ];
        };
      };
    };
  };
}
