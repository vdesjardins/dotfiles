function tmux-switch-pane-from-pid --description="switch to the tmux pane using `PID`" --argument-names=proc_pid
	set -l pid_tty (ps -o tty= -p $proc_pid)
	set -l session_values (tmux list-panes -a -F '#{session_name}:#{window_index}:#{pane_index}:#{pane_tty}' | grep $pid_tty)

	set -l session (echo $session_values | cut -d: -f1)
	set -l window_index (echo $session_values | cut -d: -f2)
	set -l pane_index (echo $session_values | cut -d: -f3)

	tmux switch -t $session:$window_index.$pane_index
end
