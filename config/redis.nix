with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-23.05-darwin.tar.gz) {});

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
