{ config, lib, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  imports = [
    ../program/neovim
    ../program/emacs
    ../program/fish
    ../program/starship
    ../program/git
    ../program/k9s
    ../program/kubectl
    ../program/tmux
    ../program/gh
    ../program/zoxide
    ../program/fzf
    ../program/terraform
    ../program/just
    ../program/openssl
    ../program/bat
    ../program/exa
    ../program/istioctl
    ../program/vault
    ../program/broot
  ];

  home.packages = with pkgs; [
    bandwhich
    bash
    bats
    bottom
    cachix
    ctags
    fd
    go
    google-cloud-sdk
    helm
    htop
    hexyl
    hyperfine
    jq
    kind
    kustomize
    lazygit
    nixfmt
    nodejs
    pueue
    ripgrep
    rustup
    skaffold
    tokei
    topgrade
    wrk
    wtf

    # language servers
    gopls
    rust-analyzer
    clang-tools
    terraform-lsp
    nodePackages.bash-language-server
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
  ];
}
