let
  nixpkgs = import <nixpkgs-22.05-darwin> {};
  nixpkgsUnstable = import <nixpkgs-unstable> {};
in [
  nixpkgs.ack
  nixpkgs.awscli2
  nixpkgs.awslogs
  nixpkgs.backblaze-b2
  nixpkgs.bash
  nixpkgs.cmake
  nixpkgs.coreutils
  nixpkgs.ctags
  nixpkgs.direnv
  nixpkgs.docker-client
  nixpkgs.fzf
  nixpkgs.gh
  nixpkgs.git
  nixpkgs.git-crypt
  nixpkgs.git-extras
  nixpkgs.gnupg
  nixpkgs.gnused
  nixpkgs.go_1_18
  nixpkgs.hivemind
  nixpkgs.htop
  nixpkgs.imagemagick
  nixpkgs.jetbrains-mono
  nixpkgs.jq
  nixpkgs.nix-direnv
  nixpkgs.nix-zsh-completions
  nixpkgs.nodejs-18_x
  nixpkgs.openssl
  nixpkgs.pgcli
  nixpkgs.postgresql_14
  nixpkgs.pwgen
  nixpkgs.redis
  nixpkgs.restic
  nixpkgs.ripgrep
  nixpkgs.rsync
  nixpkgs.ruby_3_1
  nixpkgs.shellcheck
  nixpkgs.stow
  nixpkgs.vim
  nixpkgs.virtualenv
  nixpkgs.wget
  nixpkgs.yarn
  nixpkgs.zsh
  nixpkgs.zsh-autosuggestions
  nixpkgs.zsh-completions
] ++ [
  # Unstable Packages
  # nixpkgsUnstable.riot-redis
  nixpkgsUnstable.python311
] ++ (if nixpkgs.stdenv.isDarwin then [
  # Darwin Packages
  # nixpkgs.cocoapods
] else [
])
