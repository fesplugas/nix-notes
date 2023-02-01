let
  version = "nixpkgs-22.11-darwin";
  nixpkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.openssl
      nixpkgs.ruby
    ];

    shellHook = ''
      export GEM_HOME=$HOME/.local/share/gem/ruby/2.7.0
      export GEM_PATH=$GEM_HOME
      export PATH=$GEM_HOME/bin:$PATH
      mkdir -p $GEM_HOME

      gem install bundler --version="~> 2.4.0" --no-document --conservative
    '';
  }
