function tmux-switch-pane-from-file -a filepath --description 'switch to the tmux pane using `file`'
	set -l fname (realpath $filepath)

	set -l proc_pid (lsof -t $fname 2>/dev/null)
	if test -z $proc_pid
		echo "error lsof cannot find file $fname" 1>&2
		return 1
    end

	tmux-switch-pane-from-pid $proc_pid
end
