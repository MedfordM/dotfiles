{ xdg, home, pkgs, ... }:

{
  xdg.configFile.bat = {
    source = ./.;
  };

  home.packages = [
    pkgs.bat
  ];
}
