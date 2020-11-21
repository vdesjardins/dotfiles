{ config, lib, ... }:

with lib;

mkMerge [
  {
    programs.tmux.enable = true;

    programs.fish.shellAbbrs = { t = "tmux attach -d"; };
    programs.zsh.shellAliases = { t = "tmux attach -d"; };

    home.file.".tmux.conf".source = ./tmux.conf;
    home.file.".tmux-theme.conf".source = ./tmux-theme.conf;
  }

  (mkIf config.programs.fish.enable {
    xdg.configFile."fish/functions/__tmux-refresh-env.fish".source =
      ./fish/functions/__tmux-refresh-env.fish;
    xdg.configFile."fish/functions/tmux-switch-pane-from-file.fish".source =
      ./fish/functions/tmux-switch-pane-from-file.fish;
    xdg.configFile."fish/functions/tmux-switch-pane-from-pid.fish".source =
      ./fish/functions/tmux-switch-pane-from-pid.fish;
  })

  (mkIf config.programs.zsh.enable {
    programs.zsh.initExtra = ''
      preexec_functions+=(__tmux-refresh-env-preexec)
    '';

    xdg.configFile."zsh/functions/__tmux-refresh-env-preexec".source =
      ./zsh/functions/__tmux-refresh-env-preexec;
    xdg.configFile."zsh/functions/tmux-switch-pane-from-file".source =
      ./zsh/functions/tmux-switch-pane-from-file;
    xdg.configFile."zsh/functions/tmux-switch-pane-from-pid".source =
      ./zsh/functions/tmux-switch-pane-from-pid;
  })
]
