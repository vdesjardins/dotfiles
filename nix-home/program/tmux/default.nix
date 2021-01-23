{ config, lib, pkgs, ... }:

with lib;

mkMerge [
  {
    programs.tmux.enable = true;

    programs.zsh.shellAliases = { t = "tmux attach -d"; };

    home.file.".tmux.conf".source = ./tmux.conf;
    home.file.".tmux-theme.conf".source = ./tmux-theme.conf;

    programs.neovim.plugins = with pkgs.vimPlugins; [
      vim-tmux-focus-events
      vim-tmux-clipboard
      vim-tmux-navigator
    ];
  }

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
