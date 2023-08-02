with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    hello
  ];
}
