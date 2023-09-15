let
  # version = "nixpkgs-23.05-darwin";
  version = "e27ca312d56522b907b998c2ff99169bf12639f2";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = [
      pkgs.cmake
      pkgs.nodejs_18
      pkgs.openssl
      pkgs.pkg-config
      pkgs.ruby_3_2
      pkgs.yarn
    ];

    _shellHook = ''
      export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0
      export GEM_PATH=$GEM_HOME
      export PATH=$GEM_HOME/bin:$PATH
    '';
  }
