{ config, lib, pkgs, ... }: {
  programs.neovim.plugins = with pkgs.vimPlugins;
    with pkgs; [
      coc-vimlsp
      vim-scriptease
      vim-vint
    ];
}
