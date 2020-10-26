function tls-server-dump --description="Dump remote server TLS certificate info" --argument-names=host port server_name
	if test -z $server_name
		set server_name host
	end

	true | openssl s_client -showcerts -connect $host:$port -servername $server_name | openssl x509 -noout -text
end
