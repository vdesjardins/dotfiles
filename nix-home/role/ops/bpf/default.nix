{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    bpftool
    linuxPackages.bpftrace
    linuxPackages.bcc
  ];
}
