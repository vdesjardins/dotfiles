{ config, lib, pkgs, ... }:

with lib;

{
  programs.bat = {
    enable = true;

    config = { theme = "Sublime Snazzy"; };
  };

  programs.fish.shellAliases = { cat = "bat"; };

  programs.zsh = {
    shellAliases = { cat = "bat"; };
    shellGlobalAliases = {
      BJ = "|& bat -ljson";
      BY = "|& bat -lyaml";
      BT = "|& bat";
    };
  };

  home.sessionVariables = { PAGER = "bat"; };
}
