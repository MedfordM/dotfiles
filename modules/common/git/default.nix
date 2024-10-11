{ xdg, ... }:

{
  xdg.configFile.gitGenericConfig = {
    source = ./config;
    target = "./git/config";
  };

  xdg.configFile.gitWorkConfig = {
    source = ./config-work;
    target = "./git/config-work";
  };

  xdg.configFile.gitPersonalConfig = {
    source = ./config-personal;
    target = "./git/config-personal";
  };
}
