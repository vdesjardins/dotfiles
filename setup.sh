#!/bin/bash

cfg_list=(zshrc tmux.conf vimrc pythonrc pryrc gitconfig bashrc editorconfig gitexcludes)

for f in ${cfg_list[@]}; do
        if ! [[ -L ~/.${f} ]]; then
                mv ~/.${f} ~/.${f}.bck
        fi
        rm ~/.${f}

        ln -s ~/dotfiles/${f} ~/.${f}
done

# Special VIM files
mkdir ~/.vim
ln -s ~/dotfiles/vim/UltiSnips ~/.vim/

# special case without dot in front of the dest file.
rm ~/.ssh/config
ln -s ~/dotfiles/ssh/config ~/.ssh/config

# NVIM
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/UltiSnips ~/.config/nvim/

# docker
mkdir ~/.docker
if [[ ! -f ~/docker/config.json ]]; then
        cp ~/dotfiles/docker/config.json ~/.docker/config.json
fi

# vim
mkdir ~/.vimundo ~/.vimbkp

# setup Power Level 9000 ZSH theme
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
        git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi
