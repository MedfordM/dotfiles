{ config, lib, ... }:

{
  options = {
    firefox.enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf (config.firefox.enable) {
    home-manager.users.${config.user} = {
      home.file.fireFoxUserChrome = {
        source = ../../../config/firefox/chrome;
        target = "./.mozilla/firefox/mike/chrome";
      };

      programs.firefox = {
        enable = true;
        profiles = {
          mike = {
            name = "Mike";
            isDefault = true;
            settings = {
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            };
          };
        };
      };
    };
  };
}
