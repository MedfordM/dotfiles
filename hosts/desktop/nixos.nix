{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
    ./hardware-configuration.nix
		./configuration.nix
    ../../configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../common/config.nix
	];
}
