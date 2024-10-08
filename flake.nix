{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .
    # OR
    # $ darwin-rebuild build --flake .#Michaels-MacBook-Pro
    darwinConfigurations."Michaels-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ ./configuration.nix ];
      specialArgs = { inherit inputs; };
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Michaels-MacBook-Pro".pkgs;
  };
}
