{ pkgs ? import <nixpkgs> {} }:

let
  ruby_3_2 = pkgs.ruby.overrideAttrs(attrs: {
    version = "3.2.0";
    src = pkgs.fetchurl {
      url = "https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.gz";
      sha256 = "daaa78e1360b2783f98deeceb677ad900f3a36c0ffa6e2b6b19090be77abc272";
    };
    patches = [];
    postPatch = "";
  });
in pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby_3_2

    cmake
    nodejs-16_x
    openssl
    pkg-config
    rubyPackages_3_1.rugged
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
