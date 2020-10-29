{ config, lib, pkgs, ... }:

with lib;

{
  programs.fish = {
    enable = true;

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