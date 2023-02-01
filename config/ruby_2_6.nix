let
  version = "nixpkgs-21.05-darwin";
  nixpkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.openssl
      nixpkgs.ruby_2_6
      nixpkgs.pkg-config
      nixpkgs.cmake
    ];

    shellHook = ''
      export GEM_HOME=$HOME/.local/share/gem/ruby/2.6.0
      export GEM_PATH=$GEM_HOME
      export PATH=$GEM_HOME/bin:$PATH
      mkdir -p $GEM_HOME

      gem install bundler --version="~> 2.4.0" --no-document --conservative
    '';
  }
