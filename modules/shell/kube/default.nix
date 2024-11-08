{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kompose
    kubectl
    kubernetes
    minikube
  ];

  services.kubernetes = {
    addons.dns.enable = true;
    kubelet.extraOpts = "--fail-swap-on=false";
  };
}
