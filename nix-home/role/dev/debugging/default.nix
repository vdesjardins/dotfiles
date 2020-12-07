{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    gdb
    gdbgui
    rr-unstable
  ];
}
