let
  nixpkgs = import <nixpkgs-22.11-darwin> {};
  postgresql = "postgresql_15";
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
