{ config, lib, pkgs, ... }:

with lib;

{
  programs.bat = {
    enable = true;

    config = {
      theme = "Sublime Snazzy";
      paging = "never";
    };
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

  home.sessionVariables = { MANPAGER = "sh -c 'col -bx | bat --paging=always -l man -p'"; };
}
