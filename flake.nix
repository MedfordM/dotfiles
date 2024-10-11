{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
  rec {
    targets.genericLinux.enable = true;
    darwinConfigurations."Michaels-MacBook-Pro" = import ./hosts/macbook.nix { inherit inputs; };

    homeConfigurations = {
      # "michaelmedford" = import ./home.nix {inherit inputs; };
      "michaelmedford" = darwinConfigurations."Michaels-MacBook-Pro".config.home-manager.users.michaelmedford.home;
    };
  };
}
