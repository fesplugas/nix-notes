# with import <nixpkgs> { };
# [
#   cowsay
#   jujutsu
#   hello
# ]

with import <nixpkgs> { };
buildEnv {
  name = "my-tools";
  paths = [
    cowsay
    helix
    hello
    jujutsu
    ripgrep
  ];
}

# let
#   version = "nixpkgs-unstable";
#   pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
# in
#   pkgs.mkShell {
#     packages = with pkgs; [
#       cowsay
#       hello
#     ];
#   }
