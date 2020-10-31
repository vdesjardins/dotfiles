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
    ../../program/direnv
    ../../program/any-nix-shell
    ../../program/ls
    ../../program/comma
  ];

  home.packages = with pkgs; [
    act
    bandwhich
    coreutils
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
