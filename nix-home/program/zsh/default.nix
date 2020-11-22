{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;

    autocd = true;
    enableAutosuggestions = true;

    shellGlobalAliases = {
      "..." ="../..";
      "...." = "../../..";
      "....." = "../../../..";
      DN = "/dev/null";
      EG = "|& egrep";
      EL = "|& less";
      ET = "|& tail";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "globalias" ];
    };

    initExtraBeforeCompInit = ''
      fpath=( ${config.xdg.configHome}/zsh/functions "''${fpath[@]}" )
      autoload -Uz ''$fpath[1]/*
    '';
  };
}
