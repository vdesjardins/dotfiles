if [ "$(uname)" = "Linux" ]; then
  export ZPLUG_HOME=~/.zplug
  export ZPLUG_LOADFILE=~/dotfiles/zsh/packages.zsh

  if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug $ZPLUG_HOME
  fi

  source ~/.zplug/init.zsh

  if ! zplug check --verbose; then
    echo; zplug install
  fi

  zplug load

  # Watch other user login/out
  watch=notme
  export LOGCHECK=60

  for f in $(ls -1 ~/dotfiles/shells/*); do
      source ${f}
  done

  source ~/dotfiles/zsh/config

  # use .localzshrc for settings specific to one system
  [[ -f ~/.localzshrc ]] && .  ~/.localzshrc

  # load bash local config too.
  [[ -f ~/.local.env ]] && source ~/.local.env
  [[ -f ~/.local.config ]] && source ~/.local.config
  [[ -f ~/.local.aliases ]] && source ~/.local.aliases

fi

# add platform specific zshrc
if [ -f $HOME/.zshrc-$(uname) ]; then
  . $HOME/.zshrc-$(uname)
fi

# Add host/domain specific zshrc
if [ -f $HOME/.zshrc-$(uname)-$HOST ]; then
  . $HOME/.zshrc-$(uname)-$HOST
fi

if [ -f $HOME/.zshrc-$(uname)-$(hostname) ]; then
  . $HOME/.zshrc-$(uname)-$(hostname)
fi

export PATH="$HOME/.rbenv/bin:$PATH"

# disable auto correct
unsetopt correct_all

# load custom completions
if [[ -d ~/dotfiles/zsh/completions/ ]]; then
  for f in ~/dotfiles/zsh/completions/*.zsh; do
    source $f
  done
fi
# The next line updates PATH for the Google Cloud SDK.
if [[ -d $HOME/google-cloud-sdk ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
[[ -d $HOME/google-cloud-sdk ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
command -v vault >/dev/null 2>&1 && complete -o nospace -C /usr/local/bin/vault vault
