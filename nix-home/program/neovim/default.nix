{ config, pkgs, ... }:
let
  coc-settings = import ./coc-settings.nix {};
in
{
  nixpkgs.overlays = [
    (
      import (
        builtins.fetchTarball {
          url =
            "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
        }
      )
    )
  ];
  programs.neovim = {
    enable = true;

    package = pkgs.neovim-nightly;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withPython = false;

    withNodeJs = true;

    withRuby = false;

    extraPackages = with pkgs; [ ctags tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      vim-sensible
      ale
      gundo-vim
      vim-fugitive
      vim-surround
      rainbow_parentheses-vim
      vim-gitgutter
      vim-easytags
      vim-misc
      vim-endwise
      vim-rooter
      coc-nvim
      coc-fzf
      coc-git
      coc-json
      coc-snippets
      coc-yank
      coc-lists
      float-preview-nvim
      ultisnips
      vim-snippets
      vim-toml
      vim-commentary
      nerdtree
      nerdtree-git-plugin
      vim-nerdtree-syntax-highlight
      tagbar
      vim-airline
      vim-airline-themes
      vim-repeat
      vim-easy-align
      editorconfig-vim
      splitjoin-vim
      vim-better-whitespace
      neoformat
      vim-gist
      webapi-vim
      fzf-vim
      auto-pairs
      echodoc-vim
      vim-which-key
      vim-json
      vim-dispatch
      vim-abolish
      #vim-markdown-composer
      vim-devicons
    ];

    extraConfig = builtins.readFile ./vimrc;
  };

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON coc-settings;
}
