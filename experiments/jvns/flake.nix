{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.buildEnv {
      name = "julia-stuff";
      paths = with nixpkgs.legacyPackages.aarch64-darwin; [
        cowsay
        ruby
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
