{
  description = "System flake";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
  rec {
    darwinConfigurations."Michaels-MacBook-Pro" = import ./hosts/macbook/darwin.nix { inherit inputs; };

    nixosConfigurations.nixos = import ./hosts/desktop/nixos.nix { inherit inputs; };

    homeConfigurations = {
      michaelmedford = darwinConfigurations."Michaels-MacBook-Pro".config.home-manager.users.michaelmedford.home;
    };
  };
}
