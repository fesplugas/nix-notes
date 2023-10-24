let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      cmake
      libyaml
      nodejs_18
      openssl
      pkg-config
      postgresql
      ruby_3_2
      yarn
    ];

    BUNDLE_CACHE_ALL="true";

    shellHook = ''
      # export GEM_HOME=$HOME/.local/share/gem/ruby/3.2.0
      # export GEM_PATH=$GEM_HOME
      # export PATH=$GEM_HOME/bin:$PATH
      # export PATH="$HOME/.local/share/rtx/shims:$PATH"
      export PATH="./bin:$PATH"
    '';
  }
