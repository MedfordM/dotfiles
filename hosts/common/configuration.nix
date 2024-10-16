{ config, lib, pkgs, home-manager, ... }:

{
  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "Primary user of the system";
      default = (if pkgs.stdenv.isDarwin then
          "michaelmedford"
        else
          "mike");
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
    environment.systemPackages = with pkgs; [ 
      gnumake
      gcc
      git
      neovim
      fzf
    ];

    environment.variables.EDITOR = "nvim";
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = "nix-command flakes";

    users.users.${config.user} = {
      home = config.homeDirectory;
      shell = pkgs.zsh;
    };

    home-manager.backupFileExtension = "backup";
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${config.user} = import ../../home.nix { inherit config pkgs home-manager; };
  };
}
