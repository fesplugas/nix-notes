with (import <nixpkgs-23.05> {});
mkShell {
  buildInputs = [
    python38
  ];
}
