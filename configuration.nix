{ inputs, pkgs, ... }:

{
  environment.systemPackages = [ 
    pkgs.vim
    pkgs.fzf
    pkgs.jdt-language-server
    pkgs.maven
    pkgs.postgresql
    pkgs.clickhouse
    pkgs.zookeeper
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  #  The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  users.users.michaelmedford = {
    name = "michaelmedford";
    home = "/Users/michaelmedford";
  };
}
