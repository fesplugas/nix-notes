let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    name = "hello-world";
    buildInputs = [
      pkgs.hello
    ];
    shellHook = ''
      echo "You are using a nix-shell (enabled with direnv)"
    '';
  }
