with (import <nixpkgs-22.11-darwin> {});
mkShell {
  name = "hello-world";
  buildInputs = [
    hello
  ];
  shellHook = ''
    echo "You are using a nix-shell!"
  '';
}
