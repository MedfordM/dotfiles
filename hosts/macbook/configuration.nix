{ config, ... }:

{
  config = {
    services.nix-daemon.enable = true;
    system.stateVersion = 5;
    kitty.enable = true;
  };
}
