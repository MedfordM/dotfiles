{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/shell/alias
    ../../modules/shell/var
    ../../modules/shell/starship
    ../../modules/shell/zsh
    ../../modules/shell/bat
    ../../modules/shell/git
    ../../modules/shell/nvim
    ../../modules/shell/zellij
    ../../modules/shell/zoxide
    ../../modules/shell/fzf

    ../../modules/applications/kitty
    ../../modules/applications/firefox

    ../../modules/services/windowManagers/hyprland
  ];

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

    layout = lib.mkOption {
      type = lib.types.str;
      description = "Keyboard layout";
      default = (if pkgs.stdenv.isDarwin then
          "QWERTY"
          else
          "COLEMAK");
    };
  };
  
  config = {
    environment.systemPackages = with pkgs; [ 
      gnumake
      gcc
      git
      neovim
      ripgrep
      fzf
      fd
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

    home-manager.users.${config.user} = {
      home.stateVersion = "24.05";
      home.username = config.user;
      home.homeDirectory = config.homeDirectory;
      home.packages = [
        pkgs.jq
      ];
      programs.eza.enable = true;
      programs.home-manager.enable = true;
    };
  };
}
