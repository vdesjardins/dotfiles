{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ just ];

  programs.fish.shellInit = ''
      just --completions fish | source
      '';
}
