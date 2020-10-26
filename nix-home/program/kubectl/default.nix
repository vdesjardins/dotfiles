{ config, lib, pkgs, ... }:

with lib;

mkMerge [
  {
    home.packages = with pkgs; [ kubectl ];

    programs.fish = {
      plugins = [
          {
            name = "fish-kubectl-completions";
            src = builtins.fetchGit {
              url = "https://github.com/evanlucas/fish-kubectl-completions";
              ref = "master";
            };
          }
      ];

      shellAbbrs = {
        kt = "kubetail";
      };
    };
  }

  (mkIf config.programs.fish.enable {
      xdg.configFile."fish/functions/kube-inspect.fish".source = ./fish/functions/kube-inspect.fish;
      xdg.configFile."fish/functions/kube-ctx-switch.fish".source = ./fish/functions/kube-ctx-switch.fish;
      xdg.configFile."fish/functions/kube-ctx-switch-current.fish".source = ./fish/functions/kube-ctx-switch-current.fish;
      xdg.configFile."fish/functions/kube-ns-switch.fish".source = ./fish/functions/kube-ns-switch.fish;

      xdg.configFile."fish/conf.d/kubectl_abbrs.fish".source =
        pkgs.stdenv.mkDerivation {
          name = "kubectl_abbrs";

          src = builtins.fetchurl {
            name = "kubectl_aliases";
            url = "https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases";
          };

          unpackPhase = ":";

          installPhase =
            ''
            mkdir $out
            cat $src | sed 's/alias /abbr -a /' | sed "s/='/ '/" >$out/kubectl_abbrs.fish
            '';
        } + "/kubectl_abbrs.fish";
    })
]
