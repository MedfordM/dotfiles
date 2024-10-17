{ config, pkgs, ... }:

{
  config = {
    home-manager.users.${config.user}.home = {
      sessionVariables = {
        XDG_CACHE_HOME="$HOME/.cache";
        TRACING_ENABLED="false";
        MAVEN_OPTS="-Dconfig.file=$HOME/Source/darwin/localFiles/local.conf";
        LANGUAGE="en_US.UTF-8";
        LC_ALL="en_US.UTF-8";
        LANG="en_US.UTF-8";
        LC_TYPE="en_US.UTF-8";
        MANPAGER="nvim +Man!";
        QT_QPA_PLATFORMTHEME="qt5ct";
        THEME="mocha";
        LAYOUT="${config.layout}";
      };

      sessionPath = [
        "$HOME/.local/bin"
      ];
    };
  };
}
