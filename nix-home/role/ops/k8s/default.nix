{ config, lib, pkgs, ... }:
{
  imports = [
    ../../../program/k9s
    ../../../program/kubectl
    ../../../program/istioctl
  ];

  home.packages = with pkgs; [
    helm
    jq
    kind
    kubetail
    kustomize
    skaffold
  ];
}
