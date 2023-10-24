let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      python38
      libffi
    ];
  }
