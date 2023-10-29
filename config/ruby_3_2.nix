let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      libyaml
      gh
      git
      nodejs_18
      openssl
      postgresql_15
      ruby_3_2
      yarn
    ];

    BUNDLE_CACHE_ALL="true";
    # If you are on Linux you might need to set this
    # PGHOST="/tmp";

    shellHook = ''
      export PATH=$(gem env home)/bin:$PATH
    '';
  }
