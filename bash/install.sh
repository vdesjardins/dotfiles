#!/bin/bash

function install_tools() {
	install_hostess
	install_rg
	install_sh_formatter
	install_pkgs
	vim_langservers
	install_grv
}

function install_hostess() {
	local tmp_dir=$(mktemp -d)
	curl -L https://github.com/cbednarski/hostess/releases/download/v0.3.0/hostess_linux_amd64 >${tmp_dir}/hostess
	sudo cp ${tmp_dir}/hostess /usr/local/bin/hostess
	sudo chmod +x /usr/local/bin/hostess
	rm -rf ${tmp_dir}
}

function install_rg() {
	local tmp_dir=$(mktemp -d)
	curl -L https://github.com/BurntSushi/ripgrep/releases/download/0.7.1/ripgrep-0.7.1-x86_64-unknown-linux-musl.tar.gz | tar xzf - -C ${tmp_dir} --strip-components=1
	sudo cp ${tmp_dir}/rg /usr/local/bin/rg
	rm -rf ${tmp_dir}
}

function install_sh_formatter() {
	local tmp_dir=$(mktemp -d)
	curl -L https://github.com/mvdan/sh/releases/download/v2.4.0/shfmt_v2.4.0_linux_amd64 >${tmp_dir}/shfmt
	chmod +x ${tmp_dir}/shfmt
	sudo cp ${tmp_dir}/shfmt /usr/local/bin/shfmt
	rm -rf ${tmp_dir}
}

function install_pkgs() {
	sudo apt install -y highlight htop glances exuberant-ctags
}

function vim_langservers() {
	sudo npm i -g -unsafe-perm bash-language-server
}

function install_grv() {
	wget -O grv https://github.com/rgburke/grv/releases/download/v0.2.0/grv_v0.2.0_linux64
	chmod +x grv
	sudo mv grv /usr/local/bin/grv
}
