with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    cmake
    nodejs-16_x
    openssl
    pkg-config
    ruby_3_2
    yarn
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0-nix
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH

    gem install bundler --version="~> 2.4.0" --no-document --conservative
  '';
}
