{ config, lib, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      nodejs_18
    ];
  };
}
