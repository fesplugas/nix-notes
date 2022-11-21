with (import <nixpkgs-22.05-darwin> {});
mkShell {
  buildInputs = [
    cmake
    openssl
    pkg-config
    rubyPackages_3_1.rugged
    ruby_3_1
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
