{
  description = "nix-notes example";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
      ];

      # Helper function to generate outputs for each system
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

      # Create a package set for each system
      pkgsFor = system: import nixpkgs { inherit system; config.allowUnfree = true; };

      # Define the common package list
      commonPackages = pkgs: with pkgs; [
        hello
      ];
    in
    {
      packages = forAllSystems (system: {
        default =
          let
            pkgs = pkgsFor system;
          in
          pkgs.buildEnv {
            name = "nix-notes";
            paths = commonPackages pkgs;
          };
      });

      # Dev shell with the same packages
      devShells = forAllSystems (system: {
        default =
          let
            pkgs = pkgsFor system;
          in
          pkgs.mkShell {
            buildInputs = commonPackages pkgs;

            shellHook = ''
              echo "🚀 Development environment loaded!"
            '';
          };
      });
    };
}
