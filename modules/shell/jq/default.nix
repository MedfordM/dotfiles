{ config, ... }:

{
  home-manager.users.${config.user} = {
    programs.jq = {
      enable = true;
    };
  };
}
