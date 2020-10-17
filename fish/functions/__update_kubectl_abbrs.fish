function __update_kubectl_abbrs
    curl -s -o /tmp/fish-k8s-abbrs https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
    cat /tmp/fish-k8s-abbrs | sed 's/alias /abbr -a /' | sed "s/='/ '/" > ~/.config/fish/conf.d/kubectl_abbrs.fish
    rm /tmp/fish-k8s-abbrs
end
