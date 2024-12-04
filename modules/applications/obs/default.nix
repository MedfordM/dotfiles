{ config, lib, pkgs, ... }:

{
  options = {
    obs.enable = lib.mkEnableOption "obs";
  };

  config = lib.mkIf ( config.obs.enable ) {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };
}
