{ config, ... }:

{
  services.nix-daemon.enable = true;
  system.stateVersion = 5;
  home-manager.users.${config.user} = {
    home.sessionVariables = {
      XDG_CONFIG_HOME = "${config.homeDirectory}/.config";
    };
  };
}
