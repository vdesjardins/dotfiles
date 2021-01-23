{ config, pkgs, ... }:
let coc-settings = import ./coc-settings.nix { };
in {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withPython = false;

    withNodeJs = true;

    withRuby = false;

    extraPackages = with pkgs; [ ctags ];

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
      vim-devicons
    ];

    extraConfig = builtins.readFile ./vimrc;
  };

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON coc-settings;
}
