{ config, ... }:

{
  home-manager.users.${config.user} = {
    xdg.configFile.nvimAfter = {
      source = ./after;
      target = "./nvim/after";
    };

    xdg.configFile.nvimLua = {
      source = ./lua;
      target = "./nvim/lua";
    };

    xdg.configFile.nvimSpell = {
      source = ./spell;
      target = "./nvim/spell";
    };

    xdg.configFile.nvimInit = {
      source = ./init.lua;
      target = "./nvim/init.lua";
    };
  };
}
