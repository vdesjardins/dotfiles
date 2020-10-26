function kube-ctx-switch-current --description="Switch kube config context" --argument-names=cluster
	set -l KUBECONFIG ""

	if test -z $cluster
		set cluster (kubectl config get-contexts | tail -n +2 | awk '{ print $2; }' | fzf --height 50% $argv --border)
	end

	if test -z $cluster
		echo "no cluster provided."2>&1
		return 1
	end

	kubectl config use-context $cluster

end
