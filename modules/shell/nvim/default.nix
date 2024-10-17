{ config, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.nvim = {
      source = ../../../config/nvim;
    };
  };
}
