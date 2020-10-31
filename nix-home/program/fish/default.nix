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
        };
      }
      {
        name = "nix-env";
        src = builtins.fetchGit {
          url = "https://github.com/lilyball/nix-env.fish";
          ref = "master";
        };
      }
    ];

    functions = { fish_greeting = { body = "fortune"; }; };
  };

  home.packages = with pkgs; [ fortune ];
}
