{ config, pkgs, lib, ... }:

{
  options = {
    nwg-look.enable = lib.mkEnableOption "nwg-look";
  };

  config = lib.mkIf (config.nwg-look.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        nwg-look
      ];
    };
  };
}
