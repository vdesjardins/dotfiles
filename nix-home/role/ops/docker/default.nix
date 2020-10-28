{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    nodePackages.dockerfile-language-server-nodejs
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Dockerfile-vim
    ];
  };
}
