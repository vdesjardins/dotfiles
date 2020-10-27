{ config, lib, pkgs, ... }:

with lib;

{
  home.packages = with pkgs; [ openssl ];

  xdg.configFile."fish/functions/tls-server-dump.fish".source =
    mkIf config.programs.fish.enable ./fish/functions/tls-server-dump.fish;
}
