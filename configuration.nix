{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ 
    pkgs.git
    pkgs.vim
    pkgs.neovim
    pkgs.fzf
    pkgs.jdt-language-server
    pkgs.maven
    pkgs.postgresql
    pkgs.clickhouse
    pkgs.zookeeper
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Set Git commit hash for darwin-version.
  # system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
