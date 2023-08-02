with (import <nixpkgs-23.05> {});
mkShell {
  buildInputs = [
    cmake
    nodejs_18
    openssl
    pkg-config
    ruby_3_2
    yarn
  ];

  shellHook = ''
    export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0
    export GEM_PATH=$GEM_HOME
    export PATH=./bin:$GEM_HOME/bin:$PATH
    export PATH=$HOME/Code/getdreams/dreams-iac/toolbox/bin:$PATH

    gem install bundler --version="~> 2.4.0" --no-document --conservative
  '';
}
