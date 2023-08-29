let
  # version = "nixpkgs-23.05-darwin";
  version = "c540061ac8d72d6e6d99345bd2d590c82b2f58c1";
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
