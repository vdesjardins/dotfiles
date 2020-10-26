function kube-ns-switch --description="Switch default namespace for current kube context" --argument-names=ns
	if test -z $ns
		set ns (kubectl get namespaces | tail -n +2 | awk '{ print $1; }' | fzf --height 50% $argv --border)
	end

	if test -z $ns
		echo "no namespace provided." >&2
		return 1
	end

	set -l COLOR '\033[0;34m'
	set -l NC '\033[0m'
	set -l current_context (kubectl config current-context)

	printf "Switching Default Namespace to $COLOR$ns$NC\n"
	kubectl config set-context $current_context --namespace=$ns
end
