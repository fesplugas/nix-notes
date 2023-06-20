# { pkgs ? import <nixpkgs-23.05> {} }:
{ pkgs ? import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz") {} }:

let fooScript = pkgs.writeScriptBin "foo.sh" ''
  #!/bin/sh
  echo $FOO
'';

in pkgs.mkShell {
  name = "My-project build environment";
  buildInputs = [
    pkgs.hello
    fooScript
  ];
  shellHook = ''
    echo "Welcome in $name"
    export FOO="BAR"
  '';
}
