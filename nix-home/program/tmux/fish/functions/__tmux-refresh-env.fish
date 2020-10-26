function __tmux-refresh-env --description="Refresh SSH_AUTH_SOCK and DISPLAY variables" --on-event="fish_preexec"
	if set -q TMUX
		set -l sshauth (tmux show-environment | grep "^SSH_AUTH_SOCK")
		if test -z "$sshauth"
			return
		end

		set -gx SSH_AUTH_SOCK (echo "$sshauth" | string split -m 1 '=')[2]

		set -l display (tmux show-environment | grep "^DISPLAY")
		if test -z "$display"
			return
		end

		set -gx DISPLAY (echo "$display" | string split -m 1 '=')[2]
	end
end
