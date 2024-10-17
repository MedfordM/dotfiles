{ config, ... }:

{
  home-manager.users.${config.user} = {
    programs.eza = {
      enable = true;
      icons = true;
      git = true;
    };
  };
}
