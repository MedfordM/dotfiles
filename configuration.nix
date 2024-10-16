{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    gnumake
    gcc
    git
    neovim
    fzf
  ];

  environment.variables.EDITOR = "nvim";
  environment.pathsToLink = [ "/share/zsh" ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  nixpkgs.config.allowUnfree = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # Set Git commit hash for darwin-version.
  # system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  # system.stateVersion = 5;
}
