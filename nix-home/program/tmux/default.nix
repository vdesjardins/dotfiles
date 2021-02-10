{ config, lib, pkgs, ... }:

with lib;

mkMerge [
  {
    programs.tmux = { enable = true; };

    nixpkgs.overlays = [
      (self: super: {
        tmux = super.tmux.overrideDerivation (attrs: {
          src = pkgs.fetchFromGitHub {
            owner = "tmux";
            repo = "tmux";
            rev = "03430887bed001037a39e8c85a7a8282e3d1eb61";
            sha256 = "0i7x4mrhmc3awfvvhb28bw6lfcm3dv6clr0kdfh19nnlvckcqwwj";
          };
        });
      })
    ];

    programs.zsh.shellAliases = { t = "tmux attach -d"; };

    home.file.".tmux.conf".text = pkgs.callPackage ./tmux.nix { };
    home.file.".tmux-theme.conf".source = ./tmux-theme.conf;

    programs.neovim.plugins = with pkgs.vimPlugins; [
      vim-tmux-focus-events
      vim-tmux-clipboard
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
