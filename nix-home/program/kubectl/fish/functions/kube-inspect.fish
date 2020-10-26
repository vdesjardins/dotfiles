function kube-inspect --description="Run a test container on Kubernetes"
	kubectl run --rm -i -t vince-d --image=gcr.io/google-containers/toolbox --restart=Never --labels 'app=vince-d' $argv --command /bin/bash
end
