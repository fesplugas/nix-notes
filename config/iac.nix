with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz) {});

mkShell {
  buildInputs = [
    awscli2
    jq
    packer
    ruby_3_2
    terraform
    terraform-docs
    terragrunt
  ];
}
