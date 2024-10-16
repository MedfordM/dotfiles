{ inputs, ... }:


inputs.darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  modules = [
    ./configuration.nix
    inputs.home-manager.darwinModules.home-manager
    ../common/configuration.nix
    ../../modules/darwin
  ];
}

