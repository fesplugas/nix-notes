with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    cmake
    nodejs-16_x
    openssl
    pkg-config
    rubyPackages_3_1.rugged
    ruby_3_1
    yarn
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/3.1.0-nix
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
    mkdir -p $GEM_HOME

    gem install bundler --version="~> 2.4.0" --no-document --conservative
  '';
}
