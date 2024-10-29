{ config, pkgs, ... }:

{
  config = {
    home-manager.users.${config.user} = {
      programs.java = {
        enable = true;
        package = pkgs.jdk21;
      };
      home.packages = with pkgs; [
        jdt-language-server
      ];
      home.sessionVariables = {
        JDTLS="${pkgs.jdt-language-server}";
      };
      home.sessionPath = [ "${pkgs.jdt-language-server}/bin" ];
    };
  };
}
