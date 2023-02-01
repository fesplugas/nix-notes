let
  nixpkgs = import <nixpkgs-22.11-darwin> {};
  nixpkgsUnstable = import <nixpkgs-unstable> {};
in [
  # nixpkgs.python3Full
  # nixpkgs.riot-redis
  # nixpkgs.tree
  # nixpkgs.virtualenv
  nixpkgs.ack
  nixpkgs.asdf-vm
  nixpkgs.awscli2
  nixpkgs.awslogs
  nixpkgs.backblaze-b2
  nixpkgs.bash
  nixpkgs.bat
  nixpkgs.cmake
  nixpkgs.coreutils
  nixpkgs.ctags
  nixpkgs.direnv
  nixpkgs.docker-client
  nixpkgs.exa
  nixpkgs.fzf
  nixpkgs.gh
  nixpkgs.git
  nixpkgs.git-crypt
  nixpkgs.git-extras
  nixpkgs.gnupg
  nixpkgs.gnused
  nixpkgs.go
  nixpkgs.hivemind
  nixpkgs.htop
  nixpkgs.imagemagick
  nixpkgs.jetbrains-mono
  nixpkgs.jq
  nixpkgs.lsd
  nixpkgs.nix-direnv
  nixpkgs.nix-zsh-completions
  nixpkgs.nodejs-18_x
  nixpkgs.openssl
  nixpkgs.pgcli
  nixpkgs.pkg-config
  nixpkgs.postgresql_15
  nixpkgs.pwgen
  nixpkgs.python310
  nixpkgs.python310Packages.pip
  nixpkgs.rabbitmq-server
  nixpkgs.redis
  nixpkgs.restic
  nixpkgs.ripgrep
  nixpkgs.rsync
  nixpkgs.rubyPackages_3_1.openssl
  nixpkgs.ruby_3_1
  nixpkgs.shellcheck
  nixpkgs.stow
  nixpkgs.terraform
  nixpkgs.vim
  nixpkgs.wget
  nixpkgs.yarn
  nixpkgs.zsh
  nixpkgs.zsh-autosuggestions
  nixpkgs.zsh-completions
] ++ (if nixpkgs.stdenv.isDarwin then [
  # Darwin Packages
  # nixpkgs.cocoapods
] else [
])
