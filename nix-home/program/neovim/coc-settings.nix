{ ... }: {
  languageserver = {
    dockerfile = {
      command = "docker-langserver";
      filetypes = [ "dockerfile" ];
      args = [ "--stdio" ];
    };
    bash = {
      command = "bash-language-server";
      args = [ "start" ];
      filetypes = [ "sh" ];
      ignoredRootPaths = [ "~" ];
    };
    lua = {
      command = "lua-lsp";
      filetypes = [ "lua" ];
    };
    terraform = {
      command = "terraform-lsp";
      filetypes = [ "terraform" ];
      initializationOptions = { };
    };
    ccls = {
      command = "ccls";
      filetypes = [ "c" "cpp" "objc" "objcpp" ];
      rootPatterns = [ ".ccls" "compile_commands.json" ".git/" ".hg/" ];
      initializationOptions = { cache = { directory = "/tmp/ccls"; }; };
    };
    nix = {
      command = "rnix-lsp";
      filetypes = [ "nix" ];
    };
    rust = {
      command = "rust-analyzer";
      filetypes = [ "rust" ];
      rootPatterns = [ "Cargo.toml" ];
    };
  };
}
