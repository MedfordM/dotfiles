{ config, pkgs, lib, ... }: {

  config = {

    users.users."${config.user}" = {
      home = config.homeDirectory;
      shell = pkgs.zsh; # Default shell
    };

    home-manager.users.${config.user} = {
      home.sessionVariables = {
        XDG_CONFIG_HOME = "${config.homeDirectory}/.config";
      };
    };

  };

}
