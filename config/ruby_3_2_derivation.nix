with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz) {});

let
  myOpenSSL = openssl_1_1.override {
    # Add any custom OpenSSL configuration options here
  };
  myRuby = ruby_3_2.overrideAttrs (oldAttrs: {
    # Set the OpenSSL package to the custom version defined above
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ myOpenSSL ];
    buildInputs = oldAttrs.buildInputs ++ [ myOpenSSL ];
    # Disable the postUnpack function
    postUnpack = "";
  });
in
mkShell {
  buildInputs = [
    cmake
    nodejs_18
    pkg-config
    yarn
    myRuby
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH

    gem install bundler --version="~> 2.4.0" --no-document --conservative
  '';
}
