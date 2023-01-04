let
  nixpkgs = import <nixpkgs-22.11-darwin> {};
  nixpkgsUnstable = import <nixpkgs> {};
in [
  nixpkgs.ack
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
  nixpkgs.python310
  nixpkgs.python310Packages.pip
  nixpkgs.redis
  nixpkgs.restic
  nixpkgs.riot-redis
  nixpkgs.ripgrep
  nixpkgs.rsync
  nixpkgs.ruby_3_1
  nixpkgs.shellcheck
  nixpkgs.stow
  nixpkgs.terraform
  nixpkgs.tree
  nixpkgs.vim
  nixpkgs.virtualenv
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
