{ pkgs ? import <nixpkgs> {} }:

pkgs.buildEnv {
  name = "my-env";
  paths = [
    pkgs.cowsay
    pkgs.git
  ];
}
