{ xdg, ... }:

{
  xdg.configFile.hyprland = {
    source = ./hyprland.conf;
    target = "./hypr/hyprland.conf";
  };
}
