{
  description = "Dotfile Home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, utils, ... }:
    let
    pkgsForSystem = system: import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };


  mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration (rec {
      modules = [ (import ./home-manager/home.nix) ] ++ (args.modules or []);
      pkgs = pkgsForSystem (args.system or "x86_64-darwin");
      } // { inherit (args) extraSpecialArgs; });

  in utils.lib.eachSystem [ "x86_64-darwin" ] (system: rec {
      legacyPackages = pkgsForSystem system;
      devShells.default = with legacyPackages; mkShell {
      packages = [ home-manager.packages.${system}.default ];
      };
  }) // {
  homeConfigurations = {
    michaelmedford = mkHomeConfiguration {
        extraSpecialArgs = {
          };
      };
  };
    inherit home-manager;
    inherit (home-manager) packages;
};
}
