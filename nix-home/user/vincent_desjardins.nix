{ config, lib, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  imports = [
    ../role/utils
    ../program/vault
    ../role/dev/yaml
    ../role/dev/json
    ../role/dev/cpp
    ../role/dev/rust
    ../role/dev/terraform
    ../role/dev/vimscript
    ../role/dev/nix
    ../role/dev/bash
    ../role/dev/lua
    ../role/dev/golang
    ../role/dev/rust
    ../role/dev/debugging
    ../role/ops/docker
    ../role/ops/gcloud
    ../role/ops/aws
    ../role/ops/k8s
    ../role/ops/bpf
    ../role/ops/networking
  ];

  xdg.enable = true;

  home.username = "vincent_desjardins";
  home.homeDirectory = "/home/vincent_desjardins";

  home.sessionVariables = {
    VAULT_USERNAME = "inf10906";
    VAULT_ADDR = "https://vault.gcp.internal";
  };
}
