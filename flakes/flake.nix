{
  description = "my project description";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  nixConfig.bash-prompt = "\[nix-develop\]$ ";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells.default = import ./shell.nix { inherit pkgs; };
        }
      );
}
