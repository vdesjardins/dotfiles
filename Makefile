SHELL := /bin/bash

.DEFAULT_GOAL := help

GPG_EXTRA_SOCKET := $(shell gpgconf --list-dir agent-extra-socket)

.PHONY: brew-dump
## brew-dump: dump brew installed packages in Brewfile
brew-dump:
	@rm Brewfile
	@brew bundle dump

.PHONY: brew-install
## brew-install: install brew packages from Brewfile
brew-install:
	@brew bundle

.PHONY: install-coc-extensions
## install-coc-extensions: install all coc extensions
install-coc-extensions: setup-neovim
	@mkdir -p ~/.config/coc/extensions
	@cd ~/.config/coc/extensions
	@npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

.PHONY: setup
## setup: link dotfiles config files in home directory
setup: setup-symlinks setup-ssh-config setup-vim-ultisnips setup-neovim setup-docker setup-vim setup-default-python setup-rust-analyzer setup-go-pls setup-spacemacs setup-terraform-lsp setup-dockerfile-lsp

.PHONY: setup-lsp
## setup-lsp: setup all lsp servers
setup-lsp: setup-bash-lsp setup-yaml-lsp setup-go-pls setup-rust-analyzer

.PHONY: setup-rust-analyzer
## setup-rust-analyzer: update rust-analyzer binary
setup-rust-analyzer:
	@mkdir -p ~/.local/bin
	@curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
	@chmod +x ~/.local/bin/rust-analyzer

.PHONY: setup-go-pls
## setup-go-pls: update go gls
setup-go-pls:
	@go get golang.org/x/tools/gopls

.PHONY: setup-terraform-lsp
## setup-terraform-lsp: update terraform-lsp
setup-terraform-lsp:
	@mkdir -p ~/src
	@rm -rf ~/src/terraform-lsp
	@git clone https://github.com/juliosueiras/terraform-lsp.git ~/src/terraform-lsp
	@cd ~/src/terraform-lsp && \
	go mod download && \
	make && \
	make copy DST="~/.local/bin/"

.PHONY: setup-bash-lsp
## setup-bash-lsp: update bash language server
setup-bash-lsp:
	@npm i -g bash-language-server

.PHONY: setup-yaml-lsp
## setup-yaml-lsp: update yaml language server
setup-yaml-lsp:
	@npm i -g yaml-language-server

.PHONY: setup-dockerfile-lsp
## setup-dockerfile-lsp: update dockerfile language server
setup-dockerfile-lsp:
	@npm i -g dockerfile-language-server-nodejs

.PHONY: setup-spacemacs
## setup-spacemacs: install spacemacs
setup-spacemacs:
	@if ! [[ -d ~/.emacs.d ]]; then \
	  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d; \
	fi; \
    cd ~/.emacs.d && git checkout develop && git pull

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: "
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: setup-ssh-config
setup-ssh-config:
	@mkdir -p ~/.ssh
	@chmod 700 ~/.ssh
	@rm ~/.ssh/config 2>/dev/null
	@sed -e "s|gpg_extra_socket|$(GPG_EXTRA_SOCKET)|g" ~/dotfiles/ssh/config >~/.ssh/config

.PHONY: setup-vim-ultisnips
setup-vim-ultisnips:
	@mkdir -p ~/.vim
	@ln -sf ~/dotfiles/vim/UltiSnips ~/.vim/

.PHONY: setup-neovim
setup-neovim:
	@mkdir -p ~/.config/nvim
	@ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
	@ln -sf ~/dotfiles/vim/UltiSnips ~/.config/nvim/
	@ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/
	@mkdir -p ~/.config/coc/extensions
	@ln -sf ~/dotfiles/vim/package.json ~/.config/coc/extensions/package.json

.PHONY: setup-docker
setup-docker:
	@mkdir -p ~/.docker
	@if [[ ! -f ~/docker/config.json ]]; then \
		cp ~/dotfiles/docker/config.json ~/.docker/config.json; \
	fi

.PHONY: setup-vim
setup-vim:
	@mkdir -p ~/.vimundo ~/.vimbkp

.PHONY: setup-starship
setup-starship:
	@mkdir -p ~/.config
	@ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

.PHONY: setup-default-python
# this is necessary for zplug that assume that python executable exists
setup-default-python:
	mkdir -p ~/bin
	ln -s $(which python3) ~/bin/python

.PHONY: setup-symlinks
setup-symlinks:
	@cfg_list=(zshrc tmux.conf vimrc pythonrc pryrc gitconfig bashrc editorconfig gitexcludes spacemacs); \
	for f in $${cfg_list[@]}; do \
		if ! [[ -L ~/.$${f} ]]; then \
			mv ~/.$${f} ~/.$${f}.bck; \
		fi; \
		rm ~/.$${f}; \
		ln -sf ~/dotfiles/$${f} ~/.$${f}; \
	done
