{ config, lib, pkgs, ... }:

{
  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
    };
    homeDirectory = lib.mkOption {
      type = lib.types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath (if pkgs.stdenv.isDarwin then
          "/Users/${config.user}"
          else
          "/home/${config.user}");
    };
  };
  
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${config.user} = import ../../home.nix { inherit pkgs; };
  };
}
