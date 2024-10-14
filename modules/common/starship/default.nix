{ config, pkgs, home, lib, ... }:

{
  xdg.configFile.starship = {
    source = ./starship.toml;
    target = "./starship.toml";
  };

  home.packages = [
    pkgs.starship
  ];
}
