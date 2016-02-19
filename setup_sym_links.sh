#!/bin/bash

cfg_list=(zshrc tmux.conf vimrc pythonrc pryrc gitconfig bashrc)

for f in ${cfg_list[@]}; do
  if ! [[ -L ~/.${f} ]]; then
    mv ~/.${f} ~/.${f}.bck
  fi
  rm ~/.${f}

  ln -s ~/dotfiles/${f} ~/.${f}
done

# special case without dot in front of the dest file.
rm ~/.ssh/config
ln -s ~/dotfiles/ssh/config ~/.ssh/config

