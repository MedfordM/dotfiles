{ config, home, home-manager, lib, pkgs, ... }:

{
  imports = [
    ./zellij
    ./git
    ./kitty
    ./nvim
    ./bat
    ./starship
    ./shell
  ];
}
