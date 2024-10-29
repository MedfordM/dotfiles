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
