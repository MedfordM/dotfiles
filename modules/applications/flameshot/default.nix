{ config, lib, ... }:

{
  options = {
    flameshot.enable = lib.mkEnableOption "flameshot";
  };

  config = lib.mkIf (config.flameshot.enable) {
    home-manager.users.${config.user} = {
      services.flameshot = {
        enable = true;
      };
    };
  };
}
