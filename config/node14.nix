let
  nixpkgs = import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-22.05-darwin.tar.gz) {};
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.nodejs-14_x
      nixpkgs.yarn
    ];
  }
