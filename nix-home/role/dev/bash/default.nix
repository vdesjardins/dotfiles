{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    bash
    bats
    shfmt
    nodePackages.bash-language-server
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      bats
    ];
  };
}
