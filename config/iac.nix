let
  version = "nixpkgs-23.05-darwin";
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
in
  pkgs.mkShell {
    packages = with pkgs; [
      awscli2
      jq
      packer
      ruby_3_2
      terraform
      terraform-docs
      terragrunt
    ];
  }
