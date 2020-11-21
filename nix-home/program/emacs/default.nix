{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
  };

  home.file.".emacs.d" = {
    source = builtins.fetchGit {
      url = "https://github.com/syl20bnr/spacemacs";
      ref = "develop";
      rev = "ee45910a0d3b0a89b3a8e357edd220c367f9a428";
    };
    recursive = true;
  };

  home.file.".spacemacs".source = ./spacemacs;

  programs.fish.shellAliases = { em = "emacs"; };
  programs.zsh.shellAliases = { em = "emacs"; };
}
