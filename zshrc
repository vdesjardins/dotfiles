if [ "$(uname)" = "Linux" ]; then
  # Path to your oh-my-zsh configuration.
  ZSH=$HOME/.oh-my-zsh

  # Set name of the theme to load.
  # Look in ~/.oh-my-zsh/themes/
  # Optionally, if you set this to "random", it'll load a random theme each
  # time that oh-my-zsh is loaded.
  #ZSH_THEME="robbyrussell"
  #ZSH_THEME="fino"

  # Set to this to use case-sensitive completion
  # CASE_SENSITIVE="true"

  # Comment this out to disable weekly auto-update checks
  DISABLE_AUTO_UPDATE="true"

  # Uncomment following line if you want to disable colors in ls
  # DISABLE_LS_COLORS="true"

  # Uncomment following line if you want to disable autosetting terminal title.
  DISABLE_AUTO_TITLE="true"

  # Uncomment following line if you want red dots to be displayed while waiting for completion
  COMPLETION_WAITING_DOTS="true"

  # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
  # Example format: plugins=(rails git textmate ruby lighthouse)
  plugins=(git ruby rails cap gem zsh-syntax-highlighting history-substring-search node rvm svn thor bundler lein extract ssh-agent golang dircycle docker yum dnf history rsync systemd tmux chucknorris golang man mvn pip vundle)

  source $ZSH/oh-my-zsh.sh

  # Customize to your needs...
  export HISTSIZE=25000
  export SAVEHIST=10000
  setopt INC_APPEND_HISTORY
  setopt HIST_IGNORE_SPACE
  setopt HIST_REDUCE_BLANKS
  setopt HIST_VERIFY

  # Watch other user login/out
  watch=notme
  export LOGCHECK=60

  . ~/dotfiles/zsh/env
  . ~/dotfiles/zsh/config
  . ~/dotfiles/zsh/aliases

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

export PATH=$PATH:$HOME/.rvm/bin:$HOME/.local/bin # Add RVM and Python to PATH

# disable auto correct
unsetopt correct_all

# The next line updates PATH for the Google Cloud SDK.
[[ -d $HOME/google-cloud-sdk ]] && source '/home/vdesjardins/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
[[ -d $HOME/google-cloud-sdk ]] && source '/home/vdesjardins/google-cloud-sdk/completion.zsh.inc'
