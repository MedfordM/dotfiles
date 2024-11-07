{ config, lib, pkgs, ... }:

{
  options = {
    thunar.enable = lib.mkEnableOption "thunar";
  };

  config = lib.mkIf (config.thunar.enable) {
    environment.systemPackages = [
      pkgs.nvtopPackages.nvidia
    ];
  };
}
