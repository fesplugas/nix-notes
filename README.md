# nix-notes

[Install Nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#installing-a-binary-distribution)

Add a new channel an update

```
nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin
nix-channel --update
```

Install packages

```
nix-env --install --remove-all --file env.nix
```

## Home Manager

[Install Home Manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

Edit home manager configuration

```
home-manager edit
```

And then switch the configuration

```
home-manager switch
```
