{ config, lib, pkgs, ... }:

{
  options = {
    nvtop.enable = lib.mkEnableOption "nvtop";
  };

  config = lib.mkIf (config.nvtop.enable) {
    environment.systemPackages = [
      pkgs.nvtopPackages.nvidia
    ];
  };
}
