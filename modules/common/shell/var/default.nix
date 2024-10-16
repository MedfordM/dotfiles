{ home, config, lib, pkgs, ... }:

{
  imports = [ ];

  options = {
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
    home.sessionVariables = {
      GCM_CREDENTIAL_STORE="gpg";
      GCM_GPG_PATH="/usr/bin/gpg2";
      NVM_DIR="$HOME/.nvm";
      SDKMAN_DIR="$HOME/.sdkman";
      TERM="xterm-kitty";
      XDG_CACHE_HOME="$HOME/.cache";
      TRACING_ENABLED="false";
      M2_HOME="/opt/apache-maven-3.8.6";
      MAVEN_OPTS="-Dconfig.file=$HOME/Source/darwin/localFiles/local.conf";
      EDITOR="nvim";
      LANGUAGE="en_US.UTF-8";
      LC_ALL="en_US.UTF-8";
      LANG="en_US.UTF-8";
      LC_TYPE="en_US.UTF-8";
      MANPAGER="nvim +Man!";
      QT_QPA_PLATFORMTHEME="qt5ct";
      THEME="mocha";
      LAYOUT="${config.layout}";
    };

    home.sessionPath = [
      "/opt/apache-maven-3.8.6"
        "$HOME/.local/bin"
    ];
  };
}
