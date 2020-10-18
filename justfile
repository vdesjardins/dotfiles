#!/usr/bin/env just --justfile

default:
	@echo "no default task"

brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew-dump:
	rm Brewfile
	brew bundle dump

# install brew packages from Brewfile
brew-install:
	brew bundle

# install all coc extensions
install-coc-extensions: neovim
	@mkdir -p ~/.config/coc/extensions
	@cd ~/.config/coc/extensions
	@npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# configure home directory symlinks and tooling
all: home-symlinks vim-ultisnips neovim docker vim default-python spacemacs lsp

# install all lsp servers
lsp: lsp-bash lsp-yaml lsp-go lsp-rust lsp-dockerfile lsp-terraform

# update rust-analyzer binary
lsp-rust:
	#!/usr/bin/env bash
	mkdir -p ~/.local/bin
	rm ~/.local/bin/rust-analyzer 2>/dev/null
	curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer

# update go gls
lsp-go:
	go get golang.org/x/tools/gopls

# update terraform-lsp
lsp-terraform:
	#!/usr/bin/env bash
	mkdir -p ~/src
	rm -rf ~/src/terraform-lsp
	git clone https://github.com/juliosueiras/terraform-lsp.git ~/src/terraform-lsp
	cd ~/src/terraform-lsp
	go mod download
	make
	make copy DST="~/.local/bin/"

# update bash language server
lsp-bash:
	npm i -g bash-language-server

# update yaml language server
lsp-yaml:
	npm i -g yaml-language-server

# update dockerfile language server
lsp-dockerfile:
	npm i -g dockerfile-language-server-nodejs

# install spacemacs
spacemacs:
	#!/usr/bin/env bash
	if ! [[ -d ~/.emacs.d ]]; then
	  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d;
	fi;
	cd ~/.emacs.d && git checkout develop && git pull

# configure ssh config file
ssh-config:
	#!/usr/bin/env bash
	GPG_EXTRA_SOCKET=$(gpgconf --list-dir agent-extra-socket)
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	rm ~/.ssh/config 2>/dev/null
	sed -e "s|gpg_extra_socket|$GPG_EXTRA_SOCKET|g" ~/dotfiles/ssh/config >~/.ssh/config

vim-ultisnips:
	mkdir -p ~/.vim
	ln -sf ~/dotfiles/vim/UltiSnips ~/.vim/

neovim:
	mkdir -p ~/.config/nvim
	ln -sf ~/dotfiles/vimrc ~/.config/nvim/init.vim
	ln -sf ~/dotfiles/vim/UltiSnips ~/.config/nvim/
	ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/
	mkdir -p ~/.config/coc/extensions
	ln -sf ~/dotfiles/vim/package.json ~/.config/coc/extensions/package.json

docker:
	#!/usr/bin/env bash
	mkdir -p ~/.docker
	if [[ ! -f ~/docker/config.json ]]; then
		cp ~/dotfiles/docker/config.json ~/.docker/config.json;
	fi

vim:
	mkdir -p ~/.vimundo ~/.vimbkp

starship:
	mkdir -p ~/.config
	ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml

# this is necessary for zplug that assume that python executable exists
default-python:
	mkdir -p ~/bin
	ln -s $(which python3) ~/bin/python

home-symlinks: github-client-symlink
	#!/usr/bin/env bash
	cfg_list=(zshrc tmux.conf vimrc pythonrc pryrc gitconfig bashrc editorconfig gitexcludes spacemacs); \
	for f in ${cfg_list[@]}; do
		if ! [[ -L ~/.${f} ]]; then
			mv ~/.${f} ~/.${f}.bck
		fi
		rm ~/.${f}
		ln -sf ~/dotfiles/${f} ~/.${f}
	done

github-client-symlink:
	mkdir -p ~/.config/gh
	ln -s ~/dotfiles/gh-config.yml ~/.config/gh/config.yml

# setup fish shell
fish-setup:
	mkdir -p ~/.config/
	ln -s ~/dotfiles/fish ~/.config/fish

# nix-env install
nix-install:
	#!/usr/bin/env bash
	sh <(curl -L https://nixos.org/nix/install) --no-daemon

# install packages
nix-install-pkgs:
	#!/usr/bin/env bash
	pkg_list=(
		bash
		bat
		bats
		emacs
		exa
		fzf
		fish
		gh
		git
		go
		helm
		htop
		istioctl
		jq
		just
		kind
		kubectl
		kustomize
		neovim
		nix
		ripgrep
		rustup
		skaffold
		starship
		terraform
		terraform-compliance
		terraform-docs
		terraform-lsp
		tmux
		vault
	)
	for p in ${pkg_list[@]}; do
		nix-env -i ${p}
	done
# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :
