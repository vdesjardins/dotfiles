source ~/dotfiles/zsh/config

# zplug
export ZPLUG_HOME=~/.zplug
export ZPLUG_LOADFILE=~/dotfiles/zsh/packages.zsh

if [[ ! -d ~/.zplug ]]; then
        git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source ~/.zplug/init.zsh

if ! zplug check --verbose; then
        echo
        zplug install
fi

zplug load

# Watch other user login/out
watch=notme
export LOGCHECK=60

# source helpers
for f in $(ls -1 ~/dotfiles/shells/*); do
        source ${f}
done

# use .localzshrc for settings specific to one system
[[ -f ~/.localzshrc ]] && . ~/.localzshrc

# load bash local config too.
[[ -f ~/.local.env ]] && source ~/.local.env
[[ -f ~/.local.config ]] && source ~/.local.config
[[ -f ~/.local.aliases ]] && source ~/.local.aliases

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

if [[ -d ${HOME}/.rbenv ]]; then
        export PATH="$HOME/.rbenv/bin:$PATH"
fi

# load custom completions
if [[ -d ~/dotfiles/zsh/completions/ ]]; then
        for f in $(find ~/dotfiles/zsh/completions/ -mindepth 1); do
                source $f
        done
fi
export FPATH=~/dotfiles/zsh/completions/:$FPATH

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

# vim: ft=sh
