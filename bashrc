#!/bin/bash

if [ "$(uname)" = "Linux" ]; then
	for f in $(ls -1 ~/dotfiles/shells/*); do
		source ${f}
	done

	source ~/dotfiles/bash/config

	# for settings specific to one system
	[[ -f ~/.local.env ]] && source ~/.local.env
	[[ -f ~/.local.config ]] && source ~/.local.config
	[[ -f ~/.local.aliases ]] && source ~/.local.aliases
fi

export PATH="$HOME/.rbenv/bin:$PATH"

# add platform specific bashrc
if [ -f $HOME/.bashrc-$(uname) ]; then
	. $HOME/.bashrc-$(uname)
fi

# Add host/domain specific bashrc
if [ -f $HOME/.bashrc-$(uname)-$HOST ]; then
	. $HOME/.bashrc-$(uname)-$HOST
fi

if [ -f $HOME/.bashrc-$(uname)-$(hostname) ]; then
	. $HOME/.bashrc-$(uname)-$(hostname)
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Vault
command -v vault >/dev/null 2>&1 && complete -C /usr/local/bin/vault vault
