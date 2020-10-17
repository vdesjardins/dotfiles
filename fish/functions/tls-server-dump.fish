function tls-server-dump -a host -a port -a server_name --description 'Dump remote server TLS certificate info'
    if test -z $server_name
        set server_name host
    end

    true | openssl s_client -showcerts -connect $host:$port -servername $server_name | openssl x509 -noout -text
end
