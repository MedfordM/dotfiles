{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/shell/zsh
    ../../modules/shell/alias
    ../../modules/shell/starship
    ../../modules/shell/bat
    ../../modules/shell/git
    ../../modules/shell/nvim
    ../../modules/shell/zellij
    ../../modules/shell/zoxide
    ../../modules/shell/fzf
    ../../modules/shell/jq
    ../../modules/shell/eza
    ../../modules/shell/maven
    ../../modules/shell/java
    ../../modules/shell/python
    ../../modules/shell/clickhouse
    ../../modules/shell/postgresql
    ../../modules/shell/zookeeper
    ../../modules/shell/gcloud
    ../../modules/shell/pre-commit
    ../../modules/shell/pamixer
    ../../modules/shell/wl-clipboard
    ../../modules/shell/node
    ../../modules/shell/var
    ../../modules/shell/kube

    ../../modules/applications/kitty
    ../../modules/applications/firefox
    ../../modules/applications/flameshot
    ../../modules/applications/slack
    ../../modules/applications/discord
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
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.neovim-nightly.overlays.default
      ];
    };
    environment.systemPackages = with pkgs; [ 
      gnumake
      gcc
      git
      neovim
      ripgrep
      fd
      unzip
    ];
    environment.variables.EDITOR = "nvim";
    # environment.pathsToLink = [ "/share/zsh" ];

    nix.settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";
    };

    programs.zsh.enable = true;
    home-manager.backupFileExtension = "backup";
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users.${config.user} = {
      home.stateVersion = "24.05";
      home.username = config.user;
      home.homeDirectory = config.homeDirectory;
      home.packages = [ ];
      programs.home-manager.enable = true;
      programs.nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
    };

    users.users.${config.user} = {
      home = config.homeDirectory;
      shell = pkgs.zsh;
    };

  };
}
