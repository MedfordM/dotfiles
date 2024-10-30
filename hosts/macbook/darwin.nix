{ inputs, ... }:

inputs.darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  modules = [
    inputs.home-manager.darwinModules.home-manager
    ../common/configuration.nix
    ./configuration.nix
  ];
  specialArgs = { inherit inputs; };
}

