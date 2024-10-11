{ inputs, ... }:

with inputs;

darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  modules = [
    { user = "michaelmedford"; }
    ../configuration.nix
    ../modules/darwin
    home-manager.darwinModules.home-manager
    ../modules/common
  ];
}
