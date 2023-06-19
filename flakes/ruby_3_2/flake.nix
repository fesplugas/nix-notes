{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    # nixpkgs-23.05-darwin
    # nixpkgs.inputs.flake = false;
  };

  outputs = { self, nixpkgs }: {
    defaultPackage = nixpkgs.mkShell {
      name = "my-shell";
      buildInputs = [
        nixpkgs.cmake
        nixpkgs.nodejs_18
        nixpkgs.openssl
        nixpkgs.pkgconfig
        nixpkgs.ruby_3_2
        nixpkgs.yarn
      ];

      shellHook = ''
        export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0
        export GEM_PATH=$GEM_HOME
        export PATH=$GEM_HOME/bin:$PATH

        gem install bundler --version="~> 2.4.0" --no-document --conservative
      '';
    };
  };
}
