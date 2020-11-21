{ config, pkgs, ... }:
{
  programs.direnv = {
    enable = true;

    enableFishIntegration = true;
    enableZshIntegration = true;
  };
}
