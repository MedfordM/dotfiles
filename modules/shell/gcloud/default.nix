{ config, pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in
{
  home-manager.users.${config.user} = {
    home.packages = with pkgs; [
      gdk
      google-cloud-sql-proxy
    ];
  };
}
