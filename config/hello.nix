# with (import <nixpkgs> {});
with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {});

mkShell {
  name = "hello-world";
  buildInputs = [
    hello
  ];
  shellHook = ''
    echo "You are using a nix-shell!"
  '';
}
