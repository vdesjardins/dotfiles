{ config, lib, pkgs, ... }:

with lib;

{
  programs.bat = {
    enable = true;

    config = { theme = "Sublime Snazzy"; };
  };

  programs.fish.shellAliases = { cat = "bat"; };
  programs.zsh.shellAliases = { cat = "bat"; };

  home.sessionVariables = { PAGER = "bat"; };
}
