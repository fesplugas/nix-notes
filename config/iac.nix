let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = [
      pkgs.awscli2
      pkgs.jq
      pkgs.packer
      pkgs.ruby_3_2
      pkgs.terraform
      pkgs.terraform-docs
      pkgs.terragrunt
    ];
  }
