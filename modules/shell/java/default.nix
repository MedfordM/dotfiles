{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    programs.java = {
      enable = true;
      package = pkgs.jdk22;
    };
  };
}
