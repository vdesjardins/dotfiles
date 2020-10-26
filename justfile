#!/usr/bin/env just --justfile

default:
	@echo "no default task"

# configure ssh config file
ssh-config:
	#!/usr/bin/env bash
	GPG_EXTRA_SOCKET=$(gpgconf --list-dir agent-extra-socket)
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	rm ~/.ssh/config 2>/dev/null
	sed -e "s|gpg_extra_socket|$GPG_EXTRA_SOCKET|g" ~/dotfiles/ssh/config >~/.ssh/config

docker:
	#!/usr/bin/env bash
	mkdir -p ~/.docker
	if [[ ! -f ~/docker/config.json ]]; then
		cp ~/dotfiles/docker/config.json ~/.docker/config.json;
	fi

# home-manager apply
home-manager:
	home-manager switch

# nix-env install
nix-install:
	#!/usr/bin/env bash
	sh <(curl -L https://nixos.org/nix/install) --no-daemon
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager

# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :
