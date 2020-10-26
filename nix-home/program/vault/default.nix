{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ vault ];

  programs.fish.shellAbbrs = {
    vlad = "vault login -method=ldap -path=ad username=$VAULT_USERNAME";
  };

  programs.fish.functions = {
    vault-copy = {
      body = ''
	      if test -z $src
          echo "error src not set" 1>&2
          return 1
        end
	      if test -z $dst
          echo "error dst not set" 1>&2
          return 1
        end

        vault kv get -field=data -format=json "$src" | vault kv put "$dst" -
      '';
      argumentNames = [ "src" "dest" ];
      description = "copy secret content from a path src to dst";
    };
  };
}
