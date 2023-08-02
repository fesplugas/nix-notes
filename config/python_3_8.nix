with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz) {});

mkShell {
  buildInputs = [
    python38
  ];
}
