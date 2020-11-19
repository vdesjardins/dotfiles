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

    enableAutosuggestions = true;
  };
}
