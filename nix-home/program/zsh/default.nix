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

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "2f1ca128d92064ccb8984add8eeb39811c9e0b95";
          sha256 = "1imwjagaslkinhxgjimqfcfdzj470azhyx4n09m363prclgflrxf";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.2.4";
          sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
        };
      }
    ];

    initExtraBeforeCompInit = ''
      source ${config.home.homeDirectory}/.nix-profile/etc/profile.d/nix.sh

      fpath=( ${config.xdg.configHome}/zsh/functions "''${fpath[@]}" )
      autoload -Uz ''$fpath[1]/*
    '';

    initExtra = ''
      zstyle ':completion:*:descriptions' format '[%d]'

      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    '';
  };
}
