# Nix Notes

Since I started using **[Darwin][darwin]** based machines in 2003 I've used **Fink**, **MacPorts**, **Stow** and **Homebrew**.

For the last few years my go-to developer tools have been [Homebrew](https://brew.sh), [ASDF](https://github.com/asdf-vm/asdf) and [Docker](https://docs.docker.com/).

I wanted to something different to manage my development environment but with a couple of constraints:

- No need to compile packages
- Fast and reproducible

**[Nix][nix]** had been under my radar for some time but as it had, and still has, an "incredibly steep learning curve" I was postponing the adoption.

Here are my notes about how I use it.

## Install Nix

Install **Nix** using [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer#readme) which has some good defaults

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
```

Open a new terminal and run the following command to see things are working as expected

```bash
nix-shell -p hello --run "hello"
```

## Setting Up a Development Environment

### Home Manager with Nix Flakes

I use [home-manager](https://nixos.wiki/wiki/Home_Manager) to install packages that I need on my day to day work which are not project specific. I recommend installing it with [Nix Flakes](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone).

I don't use any advanced features like dotfiles management. I just use it to define and install packages.

### Flakes

I've been migrating my `shell.nix` to `flake.nix` because it simplifies a lot version pinning. You can read more about **Flakes** [here](https://nixos.wiki/wiki/Flakes).

As an example this is the `flake.nix` I use on my Rails projects:

```nix
{
  description = "ruby 3.3 environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib) genAttrs;
      supportedSystems = [ "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: genAttrs supportedSystems (system: f system);
    in
    {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              cmake
              gh
              git
              git-crypt
              gitleaks
              gnupg
              lefthook
              libyaml
              nodejs_20
              openssl
              overmind
              pkg-config
              postgresql_15
              ruby_3_3
              yarn
            ];

            shellHook = ''
              export PATH=./bin:$PATH
            '';
          };
        });
    };
}
```

To enable the flake you can run

```console
nix develop
```

Or you can use [nix-direnv](https://github.com/nix-community/nix-direnv?tab=readme-ov-file#flakes-support) to enable the console when you enter the folder.

### nix-shell (deprecated)

I use a combination of [nix-shell][nix-shell] and [direnv][direnv] to install packages required on a particular project.

First of all install `direnv`

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env --install --attr nixpkgs.direnv
```

Enable `direnv` on your `~/.zshrc` configuration

```bash
if type direnv &>/dev/null; then
  export DIRENV_LOG_FORMAT=""
  eval "$(direnv hook zsh)"
fi
```

On your project add a `shell.nix` with your package list

```nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    hello
  ];
}
```

Create an `.envrc` file and allow its execution

```bash
echo "use nix" > .envrc
direnv allow
```

Now you can run an smoke test to execute the installed command

```bash
hello
```

That's it, you have `hello` command available on that project. Now you can install `terraform`, `ruby` ... or whatever tool you need which is specific to that project.

## How do I run services?

To run services I'm using a combination of

- `shell.nix` to define the packages and pin versions
- [direnv][direnv] to start a `nix-shell`
- [hivemind](https://github.com/DarthSim/hivemind#usage) to start the processes

As an example `services/redis.nix` installs **Hivemind** and **Redis** and creates a `Procfile` which is used by **Hivemind** to start the processes.

```
nix-shell services/redis.nix
```

Once [nix-shell][nix-shell] is enabled, run `hivemind` to start the services.

## Notes

### nix-shell commands

Let's say you have a Rails application with a `shell.nix` file which defines some of its dependencies. You can run `nix-shell` to start a new shell with all the dependencies installed or you can run a `nix-shell` command to execute a command inside the new shell.

```console
nix-shell --run "bin/rails server"
```

### nix-shell

```
#!/usr/bin/env nix-shell
#!nix-shell -i bash -p restic

if [ ! -n "$RESTIC_REPOSITORY" ]; then
  echo "error: \$RESTIC_REPOSITORY not set."
  exit 1
fi

WORK_DIR=$(mktemp -d -t restic-restore-XXXXXX)

restic restore latest \
  --target $WORK_DIR \
  --include $HOME/Documents
```

### nix develop

```console
nix develop --command bash -c "bin/rails server"
```

### Custom Profiles

```console
# Create a new profile
nix-env --switch-profile /nix/var/nix/profiles/per-user/fesplugas/foo
# List installed packages
nix-env --query
# Install a new package
nix-env -iA nixpkgs.hello
# Go back to your default profile
nix-env --switch-profile $HOME/.local/state/nix/profiles/profile
```

### Uninstall Nix?

[Want to uninstall?](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#uninstalling)

[darwin]: https://en.wikipedia.org/wiki/Darwin_(operating_system)
[direnv]: https://direnv.net/
[nix]: https://nixos.org
[nix-shell]: https://nixos.org/manual/nix/stable/command-ref/nix-shell.html
[nix-direnv]: https://github.com/nix-community/nix-direnv
[nix-direnv-non-standard]: https://github.com/nix-community/nix-direnv#using-a-non-standard-file-name
