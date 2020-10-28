{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    google-cloud-sdk
  ];
}
