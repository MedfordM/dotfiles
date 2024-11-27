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
        hyprpaper
        openzone-cursors
      ];
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = [
            "${config.homeDirectory}/Pictures/river.jpeg"
            "${config.homeDirectory}/Pictures/lake.png"
            "${config.homeDirectory}/Pictures/forrest.jpg"
          ];
          wallpaper = [
            "desc:LG Electronics 27GN950 110NTKF4X333, ${config.homeDirectory}/Pictures/river.jpeg"
            "desc:LG Electronics LG ULTRAGEAR+ 307NTDV6F498, ${config.homeDirectory}/Pictures/forrest.jpg"
            "desc:LG Electronics LG ULTRAGEAR 012NTDVBT818, ${config.homeDirectory}/Pictures/lake.png"
          ];
        };
      };
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            after_sleep_cmd = "hyprctl dispatch dpms on";
            ignore_dbus_inhibit = false;
          };
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
