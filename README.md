# Nix Notes

Since I started using **[Darwin][darwin]** based machines in 2003 I've used **Fink**, **MacPorts**, **Stow** and **Homebrew**.

Last years my go to developer tools have been

- [Homebrew](https://brew.sh)
- [ASDF](https://github.com/asdf-vm/asdf) and [Multiple Plugins](https://github.com/asdf-vm/asdf-plugins#plugin-list)
- [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

I wanted to something different to manage my development environment but with some constraints. The new tool should be fast and reproducible. **[Nix][nix]** had been under my radar for some time but as it had, and still has, an "incredibly steep learning curve" I was postponing the adoption.

Here are my notes about how I use it.

## Install Nix and Some Global Packages

1. [Install Nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#installing-a-binary-distribution)

2. Add channels an update

    ```bash
    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin
    nix-channel --update
    ````

3. Install packages

    ```bash
    nix-env --install --remove-all --file env.nix
    ```

You can search for new packages using the CLI tools or on https://search.nixos.org/packages

## Install Custom Packages on a Project?

I use [nix-shell][nix-shell] and [nix-direnv][nix-direnv] to install custom packages or to pin versions. 

1. Enable `direnv` on your `~/.zshrc` configuration

    ```bash
    if type direnv &>/dev/null; then
      export DIRENV_LOG_FORMAT=""
      eval "$(direnv hook zsh)"
    fi
    ```

2. On your project add a `shell.nix` with your package list

    ```nix
    with (import <nixpkgs-22.05-darwin> {});
    mkShell {
      buildInputs = [
        hello
      ];
    }
    ```

3. Create a `.envrc` file

    ```
    use nix
    # You can also use a non-standard file name
    # use nix config/hello.nix
    ```

4. Allow the new `.envrc` file

    ```bash
    direnv allow
    ```

5. Verify new packages have been installed

    ```bash
    which hello
    ```

## Nix-Darwin and Services

I'm not using [nix-darwin](https://github.com/LnL7/nix-darwin) as it requires some hacks to make latest **PostgreSQL** and **Redis** versions work. To run services I'm using a combination of

- `shell.nix` to define the packages and pin versions
- [nix-direnv][nix-direnv] to start a `nix-shell`
- [hivemind](https://github.com/DarthSim/hivemind#usage) to start the processes

As an example this `shell.nix` installs **Hivemind** and **Redis** and creates a `Procfile` which is used by **Hivemind** to start the processes.

```nix
with (import <nixpkgs-22.05-darwin> {});
mkShell {
  buildInputs = [
    hivemind
    redis
  ];

  shellHook = ''
    mkdir -p data/redis
    cat << EOF > data/redis/redis.conf
    loglevel warning
    logfile ""
    dir ./data/redis
    EOF

    cat << EOF > Procfile
    redis: redis-server data/redis/redis.conf
    EOF
  '';
}
```

Once the [nix-shell][nix-shell] is enabled you run `hivemind` to start the services.

## Custom Profiles

Create a new profile

```bash
nix-env --switch-profile /nix/var/nix/profiles/per-user/$USER/foo
# List installed packages
nix-env --query
# Install a new package
nix-env -iA nixpkgs.hello
```

Go back to your default profile

```bash
nix-env --switch-profile /nix/var/nix/profiles/per-user/$USER/profile
```

[darwin]: https://en.wikipedia.org/wiki/Darwin_(operating_system)
[nix]: https://nixos.org
[nix-shell]: https://nixos.org/manual/nix/stable/command-ref/nix-shell.html
[nix-direnv]: https://github.com/nix-community/nix-direnv
[nix-direnv-non-standard]: https://github.com/nix-community/nix-direnv#using-a-non-standard-file-name
