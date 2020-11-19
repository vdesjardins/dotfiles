{ config, pkgs, ... }: {
  home.packages = with pkgs; [ just ];

  programs.zsh.initExtra = ''
    source <(just --completions zsh)
  '';

  programs.fish.shellInit = ''
    just --completions fish | source
  '';
}
