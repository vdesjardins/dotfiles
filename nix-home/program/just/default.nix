{ config, pkgs, ... }: {
  home.packages = with pkgs; [ just ];

  programs.fish.shellInit = ''
    just --completions fish | source
  '';

  programs.zsh.initExtra = ''
    source <(just --completions zsh) 2>/dev/null
  '';
}
