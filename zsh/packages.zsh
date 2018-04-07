
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Async for zsh, used by pure
zplug "mafredri/zsh-async", from:github, defer:0

# # Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

zplug "lib/history", from:oh-my-zsh
zplug 'plugins/gpg-agent', from:oh-my-zsh, ignore:oh-my-zsh.sh

# # Syntax highlighting for commands, load last
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"

zplug "plugins/systemd", from:oh-my-zsh, defer:2
zplug "plugins/docker", from:oh-my-zsh, defer:2
zplug "plugins/dnf", from:oh-my-zsh, defer:2
zplug "plugins/golang", from:oh-my-zsh, defer:2
zplug "plugins/kubectl", from:oh-my-zsh, defer:2
zplug "plugins/tmux", from:oh-my-zsh, defer:2
zplug "plugins/git-flow", from:oh-my-zsh, defer:2
zplug "plugins/git", from:oh-my-zsh, defer:2
zplug "plugins/git-extras", from:oh-my-zsh, defer:3
zplug "plugins/vault", from:oh-my-zsh, defer:2

zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf

# # Theme!
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
# zplug "afrozalm/agnosterAfro", as:theme
# zplug "themes/agnoster", from:oh-my-zsh

