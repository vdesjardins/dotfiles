{ config, pkgs, ... }:
{
  imports = [
    ../role/utils
    ../program/vault
    ../role/dev/yaml
    ../role/dev/json
    ../role/dev/cpp
    ../role/dev/rust
    ../role/dev/terraform
    ../role/dev/nix
    ../role/dev/bash
    ../role/dev/golang
    ../role/ops/docker
    ../role/ops/gcloud
    ../role/ops/k8s
  ];

  home.username = "vincent.desjardins";
  home.homeDirectory = "/home/vincent.desjardins";
}
