with (import <nixpkgs-22.11> {});

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
    export GEM_HOME=$HOME/.local/share/gem/ruby/3.1.0-nix
    export GEM_PATH=$GEM_HOME
    export PATH=$GEM_HOME/bin:$PATH
    mkdir -p $GEM_HOME
  '';
}
