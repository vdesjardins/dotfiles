{ config, lib, pkgs, ... }: {
  imports = [
    ../../../program/k9s
    ../../../program/kubectl
    ../../../program/istioctl
    ../../../program/stern
  ];

  home.packages = with pkgs; [
    kind
    kubernetes-helm
    kubetail
    kubeval
    kube3d
    kustomize
    skaffold
    telepresence
    velero
  ];
}
