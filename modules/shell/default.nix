{ lib, home-manager, pkgs, home, config, ... }:

{
  imports = [
    ./zsh
    ./alias
    ./var
  ];

  config = {
    home.file.profile = {
      source = ./profile;
      target = "./.profile";
    };
  };

}
