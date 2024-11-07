# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/applications/pavucontrol
    ../../modules/applications/thunar
    ../../modules/applications/spotify
    ../../modules/applications/mission-center
    ../../modules/services/windowManagers/hyprland
    ../../modules/services/blueman
    ../../modules/shell/nvtop
  ];

  config = {
    system.stateVersion = "24.05";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;
    security.polkit.enable = true;
    time.timeZone = "America/Chicago";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
    users.users.mike = {
      isNormalUser = true;
      description = "Mike Medford";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [
      ];
    };
    services.getty.autologinUser = "mike";
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    services.xserver.enable = true;
    environment.systemPackages = with pkgs; [ ];
    xdg.portal.wlr.enable = true;
    virtualisation.docker.enable = true;

    kitty.enable = true;
    firefox.enable = true;
    hyprland.enable = true;
    pavucontrol.enable = true;
    pamixer.enable = true;
    flameshot.enable = true;
    wl-clipboard.enable = true;
    slack.enable = true;
    blueman.enable = true;
    thunar.enable = true;
    spotify.enable = true;
    mission-center.enable = true;
    nvtop.enable = true;
  };
}
