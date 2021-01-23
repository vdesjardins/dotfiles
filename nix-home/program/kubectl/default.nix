{ config, lib, pkgs, ... }:

let
  kubectl-view-utilization =
    pkgs.callPackage ./kubectl-view-utilization.nix { };
  ksniff = pkgs.callPackage ./ksniff.nix { };

in with lib;

mkMerge [
  (mkIf config.programs.zsh.enable {
    home.packages = with pkgs; [
      kubectl
      kubectl-view-utilization
      ksniff
      gawk
      fzf
      jq
      bat
    ];

    programs.zsh = {
      initExtra = ''
        source ${config.xdg.configHome}/zsh/conf.d/kubectl_aliases
      '';

      oh-my-zsh.plugins = [ "kubectl" ];

      shellGlobalAliases = {
        SL = "--show-labels";
        OJ = "-ojson";
        OJB = "-ojson | bat -ljson";
        OY = "-oyaml";
        OYB = "-oyaml | bat -lyaml";
        OW = "-owide";
      };

      shellAliases = {
        # Produce a period-delimited tree of all keys
        kgnop =
          "kubectl get nodes -o json | jq -c 'path(..)|[.[]|tostring]|join(\".\")'";
        kgpp =
          "kubectl get pods -o json | jq -c 'path(..)|[.[]|tostring]|join(\".\")'";

        # secret dump
        kgsecd =
          "kubectl get secret -o go-template='{{range $k,$v := .data}}{{$k}}={{$v|base64decode}}{{\"\\n\"}}{{end}}'";
        # events
        kge = "kubectl get events";
        kges = "kubectl get events --sort-by=.metadata.creationTimestamp";

        # pods
        kgc =
          "kubectl get pods -o=custom-columns='POD:.metadata.name,CONTAINERS:..containers[*].name'";
        kgimg =
          "kubectl get pods -o=custom-columns='POD:.metadata.name,IMAGES:.spec.containers[*].image'";

        # context and ns switching
        kns = "kube-ns-switch";
        kctx = "kube-ctx-switch";
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
