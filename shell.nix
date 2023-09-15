let
  version = "nixpkgs-unstable";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    name = "hello-world";
    packages = [
      pkgs.hello
    ];

    shellHook = ''
      echo "You are using a nix-shell!"
    '';
  }
