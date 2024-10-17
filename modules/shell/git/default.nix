{ config, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.gitConfig = {
      source = ../../../config/git;
    };
  };
}
