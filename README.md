# Nix Notes

Since I started using **Darwin** based machines in 2003 I've used **Fink**, **MacPorts** and **Homebrew**.

Last years my go to developer tools have been

- [Homebrew](https://brew.sh)
- [ASDF](https://github.com/asdf-vm/asdf) + [Multiple Plugins](https://github.com/asdf-vm/asdf-plugins#plugin-list)
- [Docker][https://docs.docker.com/] and [Docker Compose](https://docs.docker.com/compose/)

I wanted to something different to manage my development environment but with some constraints. The new tool should be fast and reproducible. **Nix** had been under my radar for some time but as it had, and still has, an "incredibly steep learning curve" I was postponing the adoption.

Here are my notes about how I use it.

## Install Nix and Some Global Packages

1. [Install Nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#installing-a-binary-distribution)

2. Add a new channel an update

    ```bash
    nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin
    nix-channel --update
    ````

3. Install packages

    ```bash
    nix-env --install --remove-all --file env.nix
    ```

You can search for new packages using the CLI tools or on https://search.nixos.org/packages

## Install Custom Packages on a Project?

I use [nix-shell](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html) and [nix-direnv](https://github.com/nix-community/nix-direnv) to install custom packages or to pin versions. 

1. Enable `direnv` on your `~/.zshrc` configuration

    ```bash
    if type direnv &>/dev/null; then
      export DIRENV_LOG_FORMAT=""
      eval "$(direnv hook zsh)"
    fi
    ```
    
2. On your project add a `shell.nix` with your package list

    ```nix
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

    ```bash
    direnv allow
    ```
    
5. Verify new packages have been installed

    ```bash
    which jq
    ```

## Nix-Darwin and Services

I'm not using [nix-darwin](https://github.com/LnL7/nix-darwin) it requires some hacks to make latest **PostgreSQL** and **Redis** versions work.

To run services like **PostgreSQL**, **RabbitMQ**, **Redis** I'm using a combination of

- `shell.nix` to define the packages and pin versions
- [nix-direnv](https://github.com/nix-community/nix-direnv) to enable the packages
- [hivemind](https://github.com/DarthSim/hivemind#usage) to start the processes

This `shell.nix` installs Hivemind, PostgreSQL and Redis. Once the nix-shell is enabled you can run `hivemind` to start the services.

    ```nix
    let
      nixpkgs = import <nixpkgs-22.05-darwin> {};
      postgresql = "postgresql_14";
    in
      nixpkgs.mkShell {
        buildInputs = [
          nixpkgs.hivemind
          nixpkgs.${postgresql}
          nixpkgs.redis
        ];

        shellHook = ''
          export DATA=$PWD/data
          mkdir -p $DATA

          # Redis Configuration
          mkdir -p $DATA/redis
          cat << EOF > $DATA/redis/redis.conf
          loglevel warning
          logfile ""
          dir ./data/redis
          EOF

          # PostgreSQL Configuration
          export PGDATA=$DATA/${postgresql}
          if [[ ! -d "$PGDATA" ]]; then
            initdb --auth=trust --no-locale --encoding=UTF8
            echo "CREATE DATABASE $USER;" | postgres --single -E postgres
          fi

          # Create Procfile
          cat << EOF > Procfile
          postgresql: postgres -D \$PGDATA
          redis: redis-server \$DATA/redis/redis.conf
          EOF
        '';
      }
    ```
