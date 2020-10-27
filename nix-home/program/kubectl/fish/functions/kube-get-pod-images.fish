function kube-get-pod-images --argument-names=pod
	if "$pod" == ""
		kubectl get pods -ojson | jq '.items[] | . as $parent | .spec.containers[] | [$parent.metadata.name, .image] | @tsv' -Mr
	else
		kubectl get pods $pod -ojson | jq '.spec.containers[].image' -Mr
	end
end
