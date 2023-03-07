with (import <nixpkgs-22.05> {});
mkShell {
  buildInputs = [
    nodejs-14_x
    yarn
  ];
}
