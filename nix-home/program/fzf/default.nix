{ config, lib, ... }:

with lib;

{
  programs.fzf = {
    enable = true;

    enableFishIntegration = false;
  };

  programs.fish = {
    shellInit = ''
      source $HOME/.config/fish/fzf-colors.fish
      set -g FZF_CTRL_T_OPTS "--bind 'ctrl-p:toggle-preview,ctrl-e:execute-silent(emacsclient -n {})+abort' --preview-window=right:60% --preview 'bat --color=always {} 2>/dev/null'"
      '';

    plugins = [
      {
        name = "fzf.fish";
        src = builtins.fetchGit {
          url = "https://github.com/patrickf3139/fzf.fish";
          ref = "main";
        };
      }
    ];
  };

  xdg.configFile."fish/fzf-colors.fish".source = mkIf config.programs.fish.enable ./fzf-colors.fish;
}
