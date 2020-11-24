{ config, lib, pkgs, ... }:

let
  kubectl-view-utilization = import ./kubectl-view-utilization.nix { inherit pkgs; };

in

with lib;

mkMerge [
  {
    home.packages = with pkgs; [ kubectl kubectl-view-utilization ];

    programs.fish = {
      plugins = [{
        name = "fish-kubectl-completions";
        src = builtins.fetchGit {
          url = "https://github.com/evanlucas/fish-kubectl-completions";
          ref = "master";
          rev = "9a8383a0f4ed2315869b9fcd0f85039a323872a2";
        };
      }];

      shellAbbrs = {
        kvu = "kubectl view utilization -h";
      };
    };
  }

  (mkIf config.programs.fish.enable {
    home.packages = with pkgs; [ gawk fzf jq ];

    xdg.configFile."fish/functions/kube-inspect.fish".source =
      ./fish/functions/kube-inspect.fish;
    xdg.configFile."fish/functions/kube-ctx-switch.fish".source =
      ./fish/functions/kube-ctx-switch.fish;
    xdg.configFile."fish/functions/kube-ctx-switch-current.fish".source =
      ./fish/functions/kube-ctx-switch-current.fish;
    xdg.configFile."fish/functions/kube-ns-switch.fish".source =
      ./fish/functions/kube-ns-switch.fish;
    xdg.configFile."fish/functions/kube-get-pod-images.fish".source =
      ./fish/functions/kube-get-pod-images.fish;

    xdg.configFile."fish/conf.d/kubectl_abbrs.fish".source =
      pkgs.stdenv.mkDerivation {
        name = "kubectl_abbrs";

        src = builtins.fetchurl {
          name = "kubectl_aliases";
          url =
            "https://raw.githubusercontent.com/ahmetb/kubectl-aliases/9f8948e7c3ca7b4c4c6cdc1461094bce08da758c/.kubectl_aliases";
          sha256 = "17y05cphzln89i59yaaacbbnn6n62w9f95yd5imi5n0jzxjni1ps";
        };

        unpackPhase = ":";

        installPhase = ''
          mkdir $out
          cat $src | sed 's/alias /abbr -a /' | sed "s/='/ '/" >$out/kubectl_abbrs.fish
        '';
      } + "/kubectl_abbrs.fish";
  })

  (mkIf config.programs.zsh.enable {
    home.packages = with pkgs; [ gawk fzf jq ];

    programs.zsh = {
      initExtra = ''
        source ${config.xdg.configHome}/zsh/conf.d/kubectl_aliases
      '';

      oh-my-zsh.plugins = [ "kubectl" ];

      shellGlobalAliases = {
        OJ = "-ojson";
        OY = "-oyaml";
        SL = "--show-labels";
      };
    };

    xdg.configFile."zsh/functions/kube-inspect".source =
      ./zsh/functions/kube-inspect;
    xdg.configFile."zsh/functions/kube-ctx-switch".source =
      ./zsh/functions/kube-ctx-switch;
    xdg.configFile."zsh/functions/kube-ctx-switch-current".source =
      ./zsh/functions/kube-ctx-switch-current;
    xdg.configFile."zsh/functions/kube-ns-switch".source =
      ./zsh/functions/kube-ns-switch;
    xdg.configFile."zsh/functions/kube-get-pod-images".source =
      ./zsh/functions/kube-get-pod-images;

    xdg.configFile."zsh/conf.d/kubectl_aliases".source = builtins.fetchurl {
        name = "kubectl_aliases_zsh";
        url =
          "https://raw.githubusercontent.com/ahmetb/kubectl-aliases/9f8948e7c3ca7b4c4c6cdc1461094bce08da758c/.kubectl_aliases";
        sha256 = "17y05cphzln89i59yaaacbbnn6n62w9f95yd5imi5n0jzxjni1ps";
      };
  })
]
