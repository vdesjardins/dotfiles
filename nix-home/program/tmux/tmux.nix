{ pkgs, ... }: ''
  # default shell
  set-option -g default-shell ${pkgs.zsh}/bin/zsh

  # remap prefix to backtick
  set-option -g prefix `
  unbind C-b
  bind ` send-prefix

  # force a reload of the config file
  unbind-key r
  bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

  # key binding
  set-window -g mode-keys vi

  # Setup 'v' to begin selection as in Vim
  bind-key -T edit-mode-vi Up send-keys -X history-up
  bind-key -T edit-mode-vi Down send-keys -X history-down
  unbind-key -T copy-mode-vi Space     ;   bind-key -T copy-mode-vi v   send-keys -X begin-selection
  unbind-key -T copy-mode-vi Enter     ;   bind-key -T copy-mode-vi y   send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
  unbind-key -T copy-mode-vi C-v       ;   bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
  unbind-key -T copy-mode-vi [         ;   bind-key -T copy-mode-vi [   send-keys -X begin-selection
  unbind-key -T copy-mode-vi ]         ;   bind-key -T copy-mode-vi ]   send-keys -X copy-selection

  # update environment variables
  set-option -g update-environment "SSH_ASKPASS SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION DISPLAY"

  # color!
  set-option -g default-terminal "tmux-256color"
  set-option -sa terminal-overrides ',*256col*:RGB'

  # quick view of processes
  bind '~' split-window "exec htop"
  bind 'K' command-prompt -p "Man:" "split-window 'man %%'"

  # All kind of nice options
  set-option -g   bell-action any
  set-option -g   display-panes-colour red
  set-option -g   history-limit 100000
  set-option -g   message-style bg=red,fg=white
  set-option -g   pane-active-border-style bg=default,fg=red
  set-option -g   pane-border-style bg=default,fg=cyan
  set-option -g   repeat-time 500
  set-option -g   visual-activity on
  set-option -g   visual-bell off
  set-option -g   set-titles on
  set-option -g   set-titles-string ' #I-#W '
  set-option -g   base-index 1
  set-option -g   display-time 1500
  set-option -g   renumber-windows on
  set-option -sg  escape-time 0

  # statusbar
  set-option -g   status-interval 5
  set-option -g   status-justify left
  set-option -g   status-left ' #h | #{s/root//:client_key_table}'
  set-option -g   status-right ' | %Y-%m-%d %H:%M #[default]'
  set-option -g   status-style fg=white,bg=colour234,default
  set-option -g   window-status-activity-style bold
  set-option -g   pane-border-style fg=colour245
  set-option -g   pane-active-border-style fg=colour39
  set-option -g   message-style fg=colour16,bg=colour221,bold

  # Window
  bind-key b last-window

  # Window options
  set-window-option -g clock-mode-colour blue
  set-window-option -g clock-mode-style 24
  set-window-option -g monitor-activity on
  set-window-option -g xterm-keys on
  set-window-option -g automatic-rename on
  set-window-option -g aggressive-resize off

  set-window-option -g window-status-format ' #I-#W '
  set-window-option -g window-status-current-format ' #I-#W '

  # quick pane cycling
  unbind ^A
  bind ^A select-pane -t :.+

  # Pane
  unbind-key l
  bind-key h select-pane -L
  bind-key j select-pane -D
  bind-key k select-pane -U
  bind-key l select-pane -R

  # Smart pane switching with awareness of Vim splits.
  # See: https://github.com/christoomey/vim-tmux-navigator
  is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
  bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
  bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
  bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
  bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
  bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\'  'select-pane -l'

  bind-key -T copy-mode-vi 'C-h' select-pane -L
  bind-key -T copy-mode-vi 'C-j' select-pane -D
  bind-key -T copy-mode-vi 'C-k' select-pane -U
  bind-key -T copy-mode-vi 'C-l' select-pane -R
  bind-key -T copy-mode-vi 'C-\' select-pane -l

  # clear screen and history
  bind BSpace "send-keys -R C-l \; clear-history"

  # use "v" and "s" to do vertical/horizontal splits, like vim
  bind-key c new-window -c '#{pane_current_path}'
  bind-key s split-window -v -c '#{pane_current_path}'
  bind-key v split-window -h -c '#{pane_current_path}'

  # use vim resize keys with submode.
  bind-key Z switch-client -T RESIZE

  bind-key -T RESIZE k resize-pane -U \; switch-client -T RESIZE
  bind-key -T RESIZE j resize-pane -D \; switch-client -T RESIZE
  bind-key -T RESIZE h resize-pane -L \; switch-client -T RESIZE
  bind-key -T RESIZE l resize-pane -R \; switch-client -T RESIZE

  bind-key -T RESIZE K resize-pane -U 5 \; switch-client -T RESIZE
  bind-key -T RESIZE J resize-pane -D 5 \; switch-client -T RESIZE
  bind-key -T RESIZE H resize-pane -L 5 \; switch-client -T RESIZE
  bind-key -T RESIZE L resize-pane -R 5 \; switch-client -T RESIZE

  # join a pane to the current window.
  bind-key J command-prompt -p "Window to join to this one:" "join-pane -s %%"

  # session
  bind-key S choose-session
  bind-key u command-prompt -p "Name your new session:" "new-session -s %%"

  # be able to copy/paste `
  bind-key -n F11 set -g prefix `
  bind-key -n F12 set -g prefix C-o

  # save history buffer to file
  bind-key P command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -S -100000; save-buffer %1 ; delete-buffer'

  # mouse
  set-option -g mouse off

  # focus events
  set-option -g focus-events on

  # toggle mouse
  unbind m
  bind-key m \
    set-option -g mouse on \;\
    display 'Mouse: ON'

  unbind M
  bind-key M \
    set-option -g mouse off \;\
    display 'Mouse: OFF'

  # copy to system keyboard
  if-shell 'test "$(uname -s)" = "Darwin"' 'bind-key y run-shell "tmux show-buffer | pbcopy" \; display-message "Copied tmux buffer to system clipboard"'
  if-shell 'test "$(uname -s)" = "Linux"' 'bind-key y run-shell "tmux show-buffer | xclip -sel clip -i" \; display-message "Copied tmux buffer to system clipboard"'

  # automatic window renaming
  set-option -g status-interval 5
  set-option -g automatic-rename on
  set-option -g automatic-rename-format "#{b:pane_current_path}"

  # Theme
  source-file ~/.tmux-theme.conf
''
