# Nix Notes

Since I started using **[Darwin][darwin]** based machines in 2003 I've used **Fink**, **MacPorts**, **Stow** and **Homebrew**.

For the last few years my go-to developer tools have been

- [Homebrew](https://brew.sh)
- [ASDF](https://github.com/asdf-vm/asdf) and [Multiple Plugins](https://github.com/asdf-vm/asdf-plugins#plugin-list)
- [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

I wanted to something different to manage my development environment but with a couple of constraints, the new tool should be fast and reproducible. **[Nix][nix]** had been under my radar for some time but as it had, and still has, an "incredibly steep learning curve" I was postponing the adoption.

Here are my notes about how I use it.

## Install Nix

Install **Nix** using the [Official Installer](https://nixos.org/manual/nix/stable/installation/installing-binary.html#multi-user-installation)

```bash
curl -L https://nixos.org/nix/install | sh
```
Or the fantastic [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer#readme)

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
```

Verify

```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix-shell -p hello --run "hello"
```

## How do I install packages?

### With nix-env

Install some packages

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env --install --attr nixpkgs.gh # You can also use -iA short version
```

List installed packages

```bash
nix-env --query # You can also use -q short version
```

> [!NOTE]  
> Although this is not the recommended way to install packages I used it in the past to make Nix work as Homebrew. Things will work properly until you have to compile packages, because not all libraries are linked in `~/.nix-profile/lib`.

You can also pass a file the `nix-env`

```bash
nix-env --install --remove-all --file env.nix
```

You can search for new packages using the CLI tools or on https://search.nixos.org/packages

### With nix-darwin

WIP.

### With nix-shell (Custom Packages on a Project)

> [!NOTE]  
> You can also use [devenv.sh](https://devenv.sh/) to achieve a similar setup.

I use a combination of [nix-shell][nix-shell] and [direnv][direnv] to install custom packages and/or to pin versions.

First of all install `direnv`

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable # Not needed if you have done it before
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

Create an `.envrc` file

```
# nix-direnv
# https://github.com/nix-community/nix-direnv?tab=readme-ov-file#nix-direnv
# Not needed but will cache `nix-shell` environment.
# https://github.com/nix-community/nix-direnv?tab=readme-ov-file#installation
if ! has nix_direnv_version || ! nix_direnv_version 2.4.0; then
  source_url "https://raw.githubusercontent.com/nix-community/nix-direnv/2.4.0/direnvrc" "sha256-XQzUAvL6pysIJnRJyR7uVpmUSZfc7LSgWQwq/4mBr1U="
fi

use nix # You can also pass filename as `use nix example.nix`
```

Allow the new `.envrc` file

```bash
direnv allow
```

And now an smoke test ...

```bash
which hello
```

## How do I run services?

> [!NOTE]  
> You can also use [devenv.sh](https://devenv.sh/) to achieve a similar setup.
> I'm not using [nix-darwin](https://github.com/LnL7/nix-darwin) as it requires some hacks to make **PostgreSQL** and **Redis** versions work.

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

```bash
nix-shell --run "bin/rails server"
```

### Custom Profiles

Create a new profile

```bash
nix-env --switch-profile /nix/var/nix/profiles/per-user/fesplugas/foo
# List installed packages
nix-env --query
# Install a new package
nix-env -iA nixpkgs.hello
# Go back to your default profile
nix-env --switch-profile /nix/var/nix/profiles/per-user/$USER/profile
```

If you need to fix the profiles because you get `*.lock` errors

```
sudo mkdir /nix/var/nix/profiles/per-user/fesplugas                       
sudo chown -R $USER:nixbld /nix/var/nix/profiles/per-user/fesplugas
```

### Uninstall Nix?

[Want to uninstall?](https://github.com/NixOS/nix/blob/master/doc/manual/src/installation/uninstall.md#macos)

### Having problems with the SSL certificate?

Update `/etc/nix/nix.conf` and reload the deamon ...

```
echo "ssl-cert-file = /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt" | sudo tee -a /etc/nix/nix.conf

sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl load /Library/LaunchDaemons/org.nixos.darwin-store.plist
```

[darwin]: https://en.wikipedia.org/wiki/Darwin_(operating_system)
[direnv]: https://direnv.net/
[nix]: https://nixos.org
[nix-shell]: https://nixos.org/manual/nix/stable/command-ref/nix-shell.html
[nix-direnv]: https://github.com/nix-community/nix-direnv
[nix-direnv-non-standard]: https://github.com/nix-community/nix-direnv#using-a-non-standard-file-name
