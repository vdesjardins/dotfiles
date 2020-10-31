{ config, lib, pkgs, ... }:

with lib;

{
  programs.fzf = {
    enable = true;

    enableFishIntegration = true;
  };

  programs.fish = {
    shellInit = ''
      source $HOME/.config/fish/fzf-colors.fish
      set -g FZF_CTRL_T_OPTS "--bind 'ctrl-p:toggle-preview,ctrl-e:execute-silent(emacsclient -n {})+abort' --preview-window=right:60% --preview 'bat --color=always {} 2>/dev/null'"
    '';
  };

  home.packages = with pkgs; [ fd ];

  xdg.configFile."fish/fzf-colors.fish".source =
    mkIf config.programs.fish.enable ./fzf-colors.fish;
}
