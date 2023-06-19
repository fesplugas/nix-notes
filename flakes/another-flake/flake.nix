{
  description = "My-project build environment";
  nixConfig.bash-prompt = "[nix(my-project)] ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system}.pkgs;
      fooScript = pkgs.writeScriptBin "foo.sh" ''
        #!/bin/sh
        echo $FOO
      '';
    in {
      devShell.${system} = pkgs.mkShell {
        # name = "My-project build environment";
        buildInputs = [
          pkgs.git
          # pkgs.python39
          # pkgs.python39Packages.tox
          # pkgs.python39Packages.flake8
          # pkgs.python39Packages.requests
          # pkgs.python39Packages.ipython
          fooScript
        ];
        shellHook = ''
          echo "Welcome in $name"
          export FOO="BAR"
        '';
      };
    };
}
