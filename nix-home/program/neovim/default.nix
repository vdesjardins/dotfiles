{ config, pkgs, ... }:
let
  coc = import ./coc.nix;
  coc-packages = import ./coc-packages.nix;
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withPython3 = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      shfmt
    ];

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
      coc-yaml
      coc-json
      coc-go
      coc-rust-analyzer
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
      # Dockerfile-vim
      # tmuxline-vim
      # promptline-vim
      vim-easy-align
      editorconfig-vim
      ansible-vim
      splitjoin-vim
      vim-better-whitespace
      neoformat
      vim-gist
      webapi-vim
      # fzf-mru-vim
      fzf-vim
      auto-pairs
      emmet-vim
      # vim-css3-syntax
      echodoc-vim
      # nvim-miniyank
      vim-tmux-focus-events
      vim-tmux-clipboard
      vim-terraform
      vim-which-key
      typescript-vim
      vim-javascript
      # vim-jsx
      # vim-styled-components
      vim-json
      # vim-jsonpath
      vim-devicons
      vim-dispatch
      vim-abolish
      # vim-helm
      bats
      vim-nix
      rust-vim
      # animate-vim
      # lens-vim
      # markdown-preview-nvim
    ];

    extraConfig = builtins.readFile ./vimrc;

  };

  # TODO: fix this. not working anymore
  # xdg.configFile."nvim/UltiSnips/go.snippets".source = ./snippets/go.snippets;
}
