let
  version = "nixpkgs-22.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      nodejs-14_x
      yarn
    ];
  }
