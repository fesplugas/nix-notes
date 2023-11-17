let
  # version = "nixpkgs-23.05-darwin";
  version = "nixpkgs-unstable";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    name = "ruby-3.2";

    packages = [
      pkgs.gh
      pkgs.git
      pkgs.hivemind
      pkgs.lefthook
      pkgs.nodejs_18
      pkgs.postgresql_15
      pkgs.ruby_3_2
      pkgs.yarn
    ];

    inputsFrom = [
      pkgs.cmake
      pkgs.libyaml
      pkgs.openssl
      pkgs.pkg-config
      pkgs.postgresql_15
    ];

    # If you are on Linux you might need to set this
    # PGHOST="/tmp";

    shellHook = ''
      echo "You are using a nix-shell (enabled with direnv)"
      export PATH=$(gem env home)/bin:$PATH
      export PATH=./bin:$PATH
    '';
  }
