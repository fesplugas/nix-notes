let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};

  fooScript = pkgs.writeScriptBin "foo.sh" ''
    #!/bin/sh
    echo $FOO
    '';
in
  pkgs.mkShell {
    name = "My-project build environment";
    buildInputs = [
      pkgs.hello
      fooScript
    ];
    shellHook = ''
      echo "Welcome in $name"
      export FOO="bar"
    '';
  }
