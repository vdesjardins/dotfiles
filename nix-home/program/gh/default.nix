{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ gitAndTools.gh ];

  programs.gh = {
    enable = true;

    gitProtocol = "ssh";

    aliases = {
      co = "pr checkout";
      c = "pr create -f";
      m = "pr merge -r";
      s = "pr status";
    };
  };

  programs.fish.loginShellInit = ''
    gh completion -s fish | source
    '';
}
