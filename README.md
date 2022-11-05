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

## Home Manager

1. [Install Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

2. Edit home manager configuration

    ```
    home-manager edit
    ```

3. And then switch the configuration

    ```
    home-manager switch
    ```
