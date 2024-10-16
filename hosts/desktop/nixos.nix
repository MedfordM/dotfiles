{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
    ./etc/nixos/hardware-configuration.nix
		./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../common/configuration.nix
	];
}
