{ config, lib, pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 30;
    maxCacheTtl = 120;
    defaultCacheTtlSsh = 30;
    maxCacheTtlSsh = 120;
    enableSshSupport = true;
    enableScDaemon = true;

    extraConfig = ''
      ignore-cache-for-signing
      no-allow-external-cache
    '';
  };
}
