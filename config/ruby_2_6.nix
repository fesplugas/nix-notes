with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-21.05-darwin.tar.gz) {});

mkShell {
  buildInputs = [
    openssl
    ruby_2_6
    nodejs
    python2
    pkg-config
    cmake
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/2.6.0
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
  '';
}
