{
  description = "Dotfile Home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {

    defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
    homeConfigurations = {
      "michaelmedford" = home-manager.lib.homeManagerConfiguration {
        # Note: I am sure this could be done better with flake-utils or something
        pkgs = import nixpkgs { system = "x86_64-darwin"; };

        modules = [ ./home-manager/home.nix ]; # Defined later
      };
  };
}
