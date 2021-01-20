{ config, pkgs, ... }: {
  home.packages = with pkgs; [ just ];

  programs.zsh.initExtra = ''
    source <(just --completions zsh) 2>/dev/null
  '';
}
