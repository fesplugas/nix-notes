with (import <nixpkgs-21.05> {});
mkShell {
  buildInputs = [
    openssl
    ruby_2_6
    pkg-config
    cmake
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/2.6.0-nix
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH

    gem install bundler --version="~> 2.4.0" --no-document --conservative
  '';
}
