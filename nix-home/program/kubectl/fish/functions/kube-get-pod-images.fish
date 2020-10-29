function kube-get-pod-images --argument-names=pod --description="Show images used by pods"
	if test -z $pod
		kubectl get pods -ojson | jq '.items[] | . as $parent | .spec.containers[] | [$parent.metadata.name, .image] | @tsv' -Mr
	else
		kubectl get pods $pod -ojson | jq '.spec.containers[].image' -Mr
	end
end
