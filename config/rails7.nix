with (import <nixpkgs-22.11-darwin> {});
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
    export GEM_HOME=$PWD/.nix-gems
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
    export PATH=$PWD/bin:$PATH
    mkdir -p $GEM_HOME

    gem install bundler --version ">= 2.4" --no-document --conservative
    gem install foreman --no-document --conservative
  '';
}
