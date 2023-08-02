with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-22.05-darwin.tar.gz) {});

mkShell {
  buildInputs = [
    nodejs-14_x
    yarn
  ];
}
