with (import <nixpkgs-22.11-darwin> {});
mkShell {
  buildInputs = [
    awscli2
    jq
    packer
    ruby_3_1
    terraform
    terraform-docs
    terragrunt
  ];
  shellHook = ''
  '';
}
