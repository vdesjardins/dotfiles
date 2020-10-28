{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
    rust-analyzer
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      coc-rust-analyzer
      rust-vim
    ];
  };
}
