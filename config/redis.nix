with (import <nixpkgs-22.05-darwin> {});
mkShell {
  buildInputs = [
    hivemind
    redis
  ];

  shellHook = ''
    export DATA=$PWD/data

    mkdir -p $DATA/redis
    cat << EOF > $DATA/redis/redis.conf
    loglevel warning
    logfile ""
    dir ./data/redis
    EOF

    cat << EOF > Procfile
    redis: redis-server \$DATA/redis/redis.conf
    EOF
  '';
}
