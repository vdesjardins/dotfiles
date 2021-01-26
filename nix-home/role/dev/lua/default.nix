{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ luaPackages.lua-lsp lua ];
}
