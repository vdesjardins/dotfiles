{ config, lib, pkgs, ... }:
{
  imports = [
    ../../../program/terraform
  ];

  home.packages = with pkgs; [
    terraform-lsp
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-terraform
    ];
  };
}
