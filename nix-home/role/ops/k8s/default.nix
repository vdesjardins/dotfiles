{ config, lib, pkgs, ... }:
{
  imports = [
    ../../../program/k9s
    ../../../program/kubectl
    ../../../program/istioctl
  ];

  home.packages = with pkgs; [
    kind
    kubernetes-helm
    kubetail
    kube3d
    kustomize
    skaffold
    stern
    telepresence
    velero
  ];
}
