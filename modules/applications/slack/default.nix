{ config, pkgs, lib, ... }:

{
  options = {
    slack.enable = lib.mkEnableOption "slack";
  };

  config = lib.mkIf (config.slack.enable) {
    home-manager.users.${config.user} = {
      home.packages = with pkgs; [
        slack
      ];
    };
  };
}
