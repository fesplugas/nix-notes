{
  description = "nix-notes example";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) genAttrs;
      supportedSystems = [ "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: genAttrs supportedSystems (system: f system);
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              hello
            ];
          };
        });
    };
}
