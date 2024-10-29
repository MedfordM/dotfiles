{ config, lib, pkgs, ... }:

{
  options = {
    flameshot.enable = lib.mkEnableOption "flameshot";
  };

  config = lib.mkIf (config.flameshot.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        grim
        slurp
      ];
      services.flameshot = {
        enable = true;
        package = pkgs.flameshot.overrideAttrs {enableWlrSupport = true;};
      };
    };
  };
}
