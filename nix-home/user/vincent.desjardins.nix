{ config, pkgs, ... }:

{
  imports = [ ./default.nix ];

  home.username = "vincent.desjardins";
  home.homeDirectory = "/home/vincent.desjardins";
}
