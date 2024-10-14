{ inputs, ... }:

with inputs;

darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  modules = [
    ../../configuration.nix
    home-manager.darwinModules.home-manager
    ../common/config.nix
    ../../modules/darwin
  ];
}

