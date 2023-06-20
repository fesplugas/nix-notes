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
      helloScript = pkgs.writeScriptBin "hello.sh" ''
        #!/bin/sh
        echo "Hello World"
        # Show we can also echo $FOO
        echo $FOO
      '';
    in {
      devShell.${system} = pkgs.mkShell {
        name = "my-project-dev-shell";
        buildInputs = [
          pkgs.hello
          helloScript
        ];
        shellHook = ''
          echo "Welcome in $name"
          export FOO="BAR"
        '';
      };
    };
}
