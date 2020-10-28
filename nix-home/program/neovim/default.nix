{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [ ctags ];

    plugins = with pkgs.vimPlugins; [
      # vim-snazzy
      ale
      gundo-vim
      vim-fugitive
      vim-surround
      rainbow_parentheses-vim
      vim-gitgutter
      vim-easytags
      vim-misc
      # vim-session
      vim-endwise
      vim-rooter
      # vim-emacscommandline
      vim-grepper
      coc-nvim
      coc-fzf
      coc-git
      coc-json
      float-preview-nvim
      ultisnips
      vim-snippets
      # L9
      vim-toml
      vim-commentary
      nerdtree
      tagbar
      vim-airline
      vim-airline-themes
      vim-repeat
      # tmuxline-vim
      # promptline-vim
      vim-easy-align
      editorconfig-vim
      splitjoin-vim
      vim-better-whitespace
      neoformat
      vim-gist
      webapi-vim
      # fzf-mru-vim
      fzf-vim
      auto-pairs
      echodoc-vim
      # nvim-miniyank
      vim-tmux-focus-events
      vim-tmux-clipboard
      vim-which-key
      vim-json
      # vim-jsonpath
      vim-devicons
      vim-dispatch
      vim-abolish
      # vim-helm
      # animate-vim
      # lens-vim
      # markdown-preview-nvim
    ];

    extraConfig = builtins.readFile ./vimrc;
  };
}
