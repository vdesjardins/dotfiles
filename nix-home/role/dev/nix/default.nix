{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };
}
