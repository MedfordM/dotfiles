{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
		./configuration.nix
    ../common/configuration.nix
	];
  specialArgs = { inherit inputs; };
}
