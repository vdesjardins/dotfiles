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
	#!/usr/bin/env bash
	home-manager switch

# home-manager install
home-manager-install:
	#!/usr/bin/env bash
	. /home/vince/.nix-profile/etc/profile.d/nix.sh
	export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
	nix-shell '<home-manager>' -A install

# nix-env install
nix-install:
	#!/usr/bin/env bash
	mkdir -p ~/.config
	ln -sf ~/dotfiles/nix-home ~/.config/nixpkgs

	if [[ $(uname -s) == "Darwin" ]]; then
		sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --no-daemon
	else
		sh <(curl -L https://nixos.org/nix/install) --no-daemon
	fi

	source ~/.nix-profile/etc/profile.d/nix.sh
	nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
	nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	nix-channel --update

# nix-cleanup
nix-cleanup:
	#!/usr/bin/env bash
	rm -rf $HOME/{.nix-channels,.nix-defexpr,.nix-profile,.config/nixpkgs}
	sudo rm -rf /nix

# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :
