{ config, ... }:

{
  home-manager.users.${config.user} = {
    programs.eza = {
      enable = true;
      icons = "auto";
      git = true;
    };
  };
}
