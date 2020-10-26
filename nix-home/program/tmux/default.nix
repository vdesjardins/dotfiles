{ config, lib, ... }:

with lib;

mkMerge [
  {
    programs.tmux.enable = true;

    programs.fish.shellAbbrs = {
      t = "tmux attach -d";
    };

    home.file.".tmux.conf".source = ./tmux.conf;
  }

  (mkIf config.programs.fish.enable {
      xdg.configFile."fish/functions/__tmux-refresh-env.fish".source = ./fish/functions/__tmux-refresh-env.fish;
      xdg.configFile."fish/functions/tmux-switch-pane-from-file.fish".source = ./fish/functions/tmux-switch-pane-from-file.fish;
      xdg.configFile."fish/functions/tmux-switch-pane-from-pid.fish".source = ./fish/functions/tmux-switch-pane-from-pid.fish;
    }
  )
]
