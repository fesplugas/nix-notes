let
  version = "nixpkgs-23.05-darwin";
  # version = "e27ca312d56522b907b998c2ff99169bf12639f2";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = [
      pkgs.python38
      pkgs.libffi
    ];
  }
