{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation {
  name = "lua-format";

  src = fetchgit {
    url = "https://github.com/Koihik/LuaFormatter.git";
    rev = "78b3d90ca49818bc72ef4ec39409924c33daa020";
    sha256 = "0snfh4h9s0xb2cayyqzjjqg4b0vq589ln2yb0ci5n2xm15dchycl";
    fetchSubmodules = true;
  };

  buildInputs = [ cmake ];
}
