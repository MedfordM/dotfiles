{ config, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.git = {
      source = ../../../config/git;
    };
  };
}
