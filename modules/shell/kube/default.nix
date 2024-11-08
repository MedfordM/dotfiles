{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.minikube
  ];
}
