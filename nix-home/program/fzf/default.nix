{ config, lib, pkgs, ... }:

with lib;

{
  home.packages = with pkgs; [ fd bat ];

  programs.fzf = {
    enable = true;

    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.fish = {
    shellInit = ''
      source $HOME/.config/fish/fzf-colors.fish
      set -g FZF_CTRL_T_OPTS "--bind 'ctrl-p:toggle-preview,ctrl-e:execute-silent(emacsclient -n {})+abort' --preview-window=right:60% --preview '${pkgs.bat}/bin/bat --color=always {} 2>/dev/null'"
    '';
  };

  programs.zsh = {
    envExtra = ''
      source $HOME/.config/zsh/fzf-colors.zsh
      export FZF_CTRL_T_OPTS="--bind 'ctrl-p:toggle-preview,ctrl-e:execute-silent(emacsclient -n {})+abort' --preview-window=right:60% --preview '${pkgs.bat}/bin/bat --color=always {} 2>/dev/null'"
      export FZF_DEFAULT_COMMAND='${pkgs.fd}/bin/fd --type f'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    '';
  };

  xdg.configFile."fish/fzf-colors.fish".source =
    mkIf config.programs.fish.enable (builtins.fetchurl {
      name = "base16-snazzy-fish";
      url = "https://raw.githubusercontent.com/fnune/base16-fzf/006613dd52bf354d4b161c6d60479951b3e0c96e/fish/base16-snazzy.fish";
      sha256 = "1g010bghs79282dxci0gv1dzqkqxvbf3jf1p3mcmggpvx6hk5cd6";
    });

  xdg.configFile."zsh/fzf-colors.zsh".source =
    mkIf config.programs.zsh.enable (builtins.fetchurl {
      name = "base16-snazzy-zsh";
      url = "https://raw.githubusercontent.com/fnune/base16-fzf/006613dd52bf354d4b161c6d60479951b3e0c96e/bash/base16-snazzy.config";
      sha256 = "1x79dd1yspqj776mgs7krs10v6xr3wf72r6a5w5x6xsnrqwdrwf8";
    });
}
