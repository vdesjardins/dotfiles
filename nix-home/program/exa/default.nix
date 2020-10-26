{ config, lib, pkgs, ... }:

with lib;

{
  home.packages = with pkgs; [ exa ];

  programs.fish.shellAliases = {
      ls = "exa";
      l = "exa";
      ll = "exa -l";
      la = "exa -la";
      lt = "exa -T";
    };
}
