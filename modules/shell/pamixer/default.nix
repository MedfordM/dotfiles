{ config, lib, pkgs, ... }:

{
  options = {
    pamixer.enable = lib.mkEnableOption "pamixer";
  };
  
  config = lib.mkIf config.pamixer.enable {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        pamixer
      ];
    };
  };
}
