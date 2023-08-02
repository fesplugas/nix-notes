with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz) {});

mkShell {
  buildInputs = [
    hivemind
    postgresql_14
    redis
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
    export PGDATA=$DATA/postgresql
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
