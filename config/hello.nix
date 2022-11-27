with (import <nixpkgs-22.11-darwin> {});
mkShell {
  buildInputs = [
    hello
  ];
}
