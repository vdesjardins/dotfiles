function __tmux-refresh-env --on-event fish_preexec --description "Refresh SSH_AUTH_SOCK and DISPLAY variables"
	if set -q TMUX
	  set -l sshauth (tmux show-environment | grep "^SSH_AUTH_SOCK")
	  if test -z "$sshauth"
		  return
	  end

	  set SSH_AUTH_SOCK (echo "$sshauth" | string split -m 1 '=')[2]

      set -l display (tmux show-environment | grep "^DISPLAY")
	  if test -z "$display"
		  return
	  end

	  set DISPLAY (echo "$display" | string split -m 1 '=')[2]
	end
end
