{ config, pkgs, lib, ... }: {

  config = {


    home-manager.users.${config.user} = {
      home.sessionVariables = {
        XDG_CONFIG_HOME = "${config.homeDirectory}/.config";
      };
    };

  };

}
