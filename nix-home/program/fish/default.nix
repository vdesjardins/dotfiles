{ config, lib, pkgs, ... }:

with lib;

{
  programs.fish = {
    enable = true;

    shellInit = ''
      # we need to source functions on events for them to take effect.
      for f in (grep -l -E '^function\s+.*--on-.*$' ~/.config/fish/functions/*.fish)
      source $f
      end
    '';

    plugins = [
      {
        name = "pisces";
        src = builtins.fetchGit {
          url = "https://github.com/laughedelic/pisces";
          ref = "master";
          rev = "34971b9671e217cfba0c71964f5028d44b58be8c";
        };
      }
      {
        name = "nix-env";
        src = builtins.fetchGit {
          url = "https://github.com/lilyball/nix-env.fish";
          ref = "master";
          rev = "c239a69122c88797b34e3721659b2ba5060ca7e7";
        };
      }
      {
        name = "fenv";
        src = builtins.fetchGit {
          url = "https://github.com/oh-my-fish/plugin-foreign-env";
          ref = "master";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
        };
      }
    ];

    functions = { fish_greeting = { body = "fortune"; }; };
  };

  home.packages = with pkgs; [ fortune ];
}
