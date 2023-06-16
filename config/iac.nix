with (import <nixpkgs-23.05> {});

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
