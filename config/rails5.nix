let
  version = "nixpkgs-21.05-darwin";
  nixpkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.openssl
      nixpkgs.ruby_2_6
    ];

    shellHook = ''
      export GEM_HOME=$PWD/.nix-gems
      export GEM_PATH=$GEM_HOME
      export PATH=$GEM_HOME/bin:$PATH
      export PATH=$PWD/bin:$PATH
      mkdir -p $GEM_HOME

      gem install bundler --version=2.3.26 --no-document --conservative
    '';
  }
