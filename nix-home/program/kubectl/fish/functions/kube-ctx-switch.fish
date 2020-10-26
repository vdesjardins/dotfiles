function kube-ctx-switch --description="Create a new Tmux session with dedicated kube config" --argument-names=cluster
	set -l KUBECONFIG ""

	if test -z $cluster
		set cluster (kubectl config get-contexts | tail -n +2 | awk '{ print $2; }' | fzf --height 50% $argv --border)
	end

	if test -z $cluster
		echo "no cluster provided."
		return 1
	end

	set -l session_name "shell-$cluster"

	tmux list-session | cut -d':' -f1 | grep $session_name &>/dev/null
	if test $status -eq 0
		tmux switch-client -t $session_name
		return
	end

	set -l dir ~/.config/my-kubeconfig/
	mkdir -p $dir
	set -l kubeconfig "$dir/$cluster-config"
	set -l startup_script "$dir/startup-script.fish"
	cp ~/.kube/config $kubeconfig

	printf "\
#!/usr/bin/env fish
set -g KUBECONFIG $kubeconfig
kubectl config use-context $cluster
fish -l" >$startup_script

	chmod +x $startup_script

	tmux new-session -d -s $session_name $startup_script
	tmux setenv -t $session_name KUBECONFIG $kubeconfig
	tmux switch-client -t $session_name
end
