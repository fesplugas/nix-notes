let
  nixpkgs = import <nixpkgs-22.11-darwin> {};
in
  nixpkgs.mkShell {
    buildInputs = [
      nixpkgs.cmake
      nixpkgs.nodejs-16_x
      nixpkgs.openssl
      nixpkgs.pkg-config
      nixpkgs.rubyPackages_3_1.rugged
      nixpkgs.ruby_3_1
      nixpkgs.yarn
    ];

    shellHook = ''
      export GEM_HOME=$HOME/.local/share/gem/ruby/3.1.0
      export GEM_PATH=$GEM_HOME
      export PATH=$GEM_HOME/bin:$PATH
      mkdir -p $GEM_HOME

      gem install bundler --version="~> 2.4.0" --no-document --conservative
    '';
  }
