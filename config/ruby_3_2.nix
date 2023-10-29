let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      # cmake
      libyaml
      nodejs_18
      openssl
      # pkg-config
      postgresql_15
      ruby_3_2
      yarn
    ];

    BUNDLE_CACHE_ALL="true";

    shellHook = ''
      export PATH=$(gem env home)/bin:$PATH
      export PATH="./bin:$PATH"

      gem list --installed rails > /dev/null || gem install rails
    '';
  }
