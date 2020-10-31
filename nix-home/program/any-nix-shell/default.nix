{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ any-nix-shell ];

  programs.fish.promptInit = ''
      any-nix-shell fish --info-right | source
    '';
}
