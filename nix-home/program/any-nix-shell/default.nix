{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ any-nix-shell ];

  programs.fish.promptInit = ''
      any-nix-shell fish --info-right | source
    '';

  programs.zsh.initExtra = ''
    any-nix-shell zsh --info-right | source /dev/stdin
  '';
}
