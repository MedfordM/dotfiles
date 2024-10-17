{ config, lib, pkgs, ... }:

{
  options = {
    pavucontrol.enable = lib.mkEnableOption "pavucontrol";
  };

  config = lib.mkIf ( config.pavucontrol.enable ) {
    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
