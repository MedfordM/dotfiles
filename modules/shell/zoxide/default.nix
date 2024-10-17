{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd=cd" ];
    };
  };
}
