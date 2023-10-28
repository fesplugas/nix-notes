# Nix Notes

Since I started using **[Darwin][darwin]** based machines in 2003 I've used **Fink**, **MacPorts**, **Stow** and **Homebrew**.

For the last few years my go-to developer tools have been

- [Homebrew](https://brew.sh)
- [ASDF](https://github.com/asdf-vm/asdf) and [Multiple Plugins](https://github.com/asdf-vm/asdf-plugins#plugin-list)
- [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

I wanted to something different to manage my development environment but with a couple of constraints. The new tool should be fast and reproducible. **[Nix][nix]** had been under my radar for some time but as it had, and still has, an "incredibly steep learning curve" I was postponing the adoption.

Here are my notes about how I use it.

## Install Nix and Some Global Packages

Install **Nix** by using the [Official Installer](https://nixos.org/manual/nix/stable/installation/installing-binary.html#multi-user-installation) or [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer#readme)

```bash
curl -L https://releases.nixos.org/nix/nix-2.17.0/install | sh -s -- --daemon
```

Verify

```bash
nix-shell -p hello --run "hello"
```

You can search for new packages using the CLI tools or on https://search.nixos.org/packages

[Want to uninstall?](https://github.com/NixOS/nix/blob/master/doc/manual/src/installation/uninstall.md#macos)

## Install Packages?

### Without nix-darwin ...

Although this is not the recommended way to install packages I have used it in the past to make Nix work as Homebrew. Things will work properly until you have to compile packages, because not all libraries are linked in `~/.nix-profile/lib`.

```bash
nix-env --install --remove-all --file env.nix
```

### With nix-darwin

WIP.

### Custom Packages on a Project?

I use a combination of [nix-shell][nix-shell] and [nix-direnv][nix-direnv] to install custom packages and/or to pin versions.

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

```bash
use nix
# You can also use a non-standard file name
# use nix config/hello.nix
```

Allow the new `.envrc` file

```bash
direnv allow
```

Verify new packages have been installed

```bash
which hello
```

## Nix-Darwin and Services

> [!NOTE]  
> You can also use [devenv.sh](https://devenv.sh/) to achieve a similar setup.

I'm not using [nix-darwin](https://github.com/LnL7/nix-darwin) as it requires some hacks to make latest **PostgreSQL** and **Redis** versions work. To run services I'm using a combination of

- `shell.nix` to define the packages and pin versions
- [nix-direnv][nix-direnv] to start a `nix-shell`
- [hivemind](https://github.com/DarthSim/hivemind#usage) to start the processes

As an example `config/redis.nix` installs **Hivemind** and **Redis**, creates a `Procfile` which is used by **Hivemind** to start the processes.

```
nix-shell config/redis.nix
```

Once [nix-shell][nix-shell] is enabled, run `hivemind` to start the services.

## Custom Profiles

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

## Gotchas

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
[nix]: https://nixos.org
[nix-shell]: https://nixos.org/manual/nix/stable/command-ref/nix-shell.html
[nix-direnv]: https://github.com/nix-community/nix-direnv
[nix-direnv-non-standard]: https://github.com/nix-community/nix-direnv#using-a-non-standard-file-name
