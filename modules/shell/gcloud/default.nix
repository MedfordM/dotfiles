{ config, pkgs, ... }:

{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      google-cloud-sdk
    ];
  };
}
