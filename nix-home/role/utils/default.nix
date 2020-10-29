{ config, lib, pkgs, ... }:
{
  imports = [
    ../../program/neovim
    ../../program/emacs
    ../../program/fish
    ../../program/starship
    ../../program/git
    ../../program/tmux
    ../../program/gh
    ../../program/zoxide
    ../../program/fzf
    ../../program/just
    ../../program/openssl
    ../../program/bat
    ../../program/exa
    ../../program/broot
  ];

  home.packages = with pkgs; [
    bandwhich
    bottom
    cachix
    ctags
    fd
    htop
    hexyl
    hyperfine
    jq
    lazygit
    pueue
    ripgrep
    tokei
    topgrade
    wrk
    wtf
  ];
}