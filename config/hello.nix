with (import <nixpkgs-22.05-darwin> {});
mkShell {
  buildInputs = [
    hello
  ];
}
