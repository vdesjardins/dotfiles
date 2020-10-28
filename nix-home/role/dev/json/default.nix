{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      coc-json
    ];
  };
}
