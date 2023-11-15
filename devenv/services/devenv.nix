{ pkgs, ... }: {
  env.GREET = "determinism";
  packages = [ pkgs.git ];
  enterShell = "echo hello $GREET";

  # processes.ping.exec = "ping example.com";

  services.postgres.enable = true;
  services.postgres.package = pkgs.postgresql_15;
  services.postgres.listen_addresses = "127.0.0.1";

  services.redis.enable = true;

  services.rabbitmq.enable = true;
  services.rabbitmq.managementPlugin.enable = true;
}
