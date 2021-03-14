{ config, lib, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> { };

  genCacert = pkgs.runCommand "gencacert" { } ''
    mkdir -p $out
    cat ${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt ${
      ./lacapitale-root-ca.pem
    } >$out/generated-ca-bundle.crt
  '';

in {
  imports = [
    ../role/utils
    ../role/dev/nix
    ../role/dev/yaml
    ../role/dev/json
    ../role/dev/bash
    ../role/security
    ../program/alacritty
    ../program/karabiner
    ../service/gpg-agent
    ../program/ssh
    ../program/gcloud
  ];

  home.username = "vdesjardins";
  home.homeDirectory = "/Users/vdesjardins";

  home.sessionVariables = {
    NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM = 1;
    NIX_SSL_CERT_FILE = "${genCacert}/generated-ca-bundle.crt";
  };

  programs.gpg.enable = true;

  home.sessionVariables = {
    VAULT_USERNAME = "inf10906";
    VAULT_ADDR = "https://vault.gcp.internal";
  };
}
