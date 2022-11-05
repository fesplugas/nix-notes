# nix-notes

1. [Install Nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#installing-a-binary-distribution)

2. Add a new channel an update

    ```
    nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin
    nix-channel --update
    ````

3. Install packages

    ```
    nix-env --install --remove-all --file env.nix
    ```

## Install Custom Packages on a Project?

We use [nix-shell](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html) and [nix-direnv](https://github.com/nix-community/nix-direnv) to install custom packages or to pin versions. 

1. Enable `direnv` on your `~/.zshrc` configuration

    ```
    if type direnv &>/dev/null; then
      export DIRENV_LOG_FORMAT=""
      eval "$(direnv hook zsh)"
    fi
    ```
    
2. On your project add a `shell.nix` with your package list

    ```
    let
      version = "nixpkgs-22.05-darwin";
      nixpkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
    in
      nixpkgs.mkShell {
        buildInputs = [
          nixpkgs.jq
          nixpkgs.terraform
          nixpkgs.terraform-docs
          nixpkgs.terragrunt
        ];
      }
    ```

3. Create a `.envrc` file

    ```
    use nix
    ```

4. Allow the new `.envrc` file

    ```
    direnv allow
    ```
    
5. Verify new packages have been installed

    ```
    which jq
    ```
