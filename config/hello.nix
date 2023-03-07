with (import <nixpkgs> {});

mkShell {
  name = "hello-world";
  buildInputs = [
    hello
  ];
  shellHook = ''
    echo "You are using a nix-shell!"
  '';
}
