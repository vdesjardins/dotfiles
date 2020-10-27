{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
  };

  home.file.".emacs.d" = {
    source = builtins.fetchGit {
      url = "https://github.com/syl20bnr/spacemacs";
      ref = "develop";
    };
    recursive = true;
  };

  home.file.".spacemacs".source = ./spacemacs;

  programs.fish.shellAliases = { em = "emacs"; };
}
