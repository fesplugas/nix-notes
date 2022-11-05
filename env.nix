let
  # nixpkgs = import <nixpkgs-22.05-darwin> {};
  # nixpkgsUnstable = import <nixpkgs> {};

  version = "nixpkgs-22.05-darwin";
  nixpkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/${version}.tar.gz") {};
  nixpkgsUnstable = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz") {};
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
  nixpkgs.dos2unix
  nixpkgs.foreman
  nixpkgs.fzf
  nixpkgs.gh
  nixpkgs.git
  nixpkgs.git-crypt
  nixpkgs.git-extras
  nixpkgs.gitleaks
  nixpkgs.gnupg
  nixpkgs.gnused
  nixpkgs.go_1_18
  nixpkgs.haproxy
  nixpkgs.heroku
  nixpkgs.hivemind
  nixpkgs.htop
  nixpkgs.imagemagick
  nixpkgs.jetbrains-mono
  nixpkgs.jq
  nixpkgs.lefthook
  nixpkgs.nix-direnv
  nixpkgs.nix-info
  nixpkgs.nix-zsh-completions
  nixpkgs.nodejs-18_x
  nixpkgs.nomad
  nixpkgs.openssl
  nixpkgs.packer
  nixpkgs.pgcli
  nixpkgs.pkg-config
  nixpkgs.postgresql
  nixpkgs.pwgen
  nixpkgs.python2
  nixpkgs.redis
  nixpkgs.restic
  nixpkgs.ripgrep
  nixpkgs.rsync
  nixpkgs.ruby_3_1
  nixpkgs.shellcheck
  nixpkgs.ssh-tools
  nixpkgs.stow
  nixpkgs.tmux
  nixpkgs.tree
  nixpkgs.vault
  nixpkgs.vim
  nixpkgs.virtualenv
  nixpkgs.wget
  nixpkgs.yarn
  nixpkgs.zsh
  nixpkgs.zsh-autosuggestions
  nixpkgs.zsh-completions
] ++ [
  # Unstable Packages
  nixpkgsUnstable.asdf-vm
  nixpkgsUnstable.python311
  nixpkgsUnstable.riot-redis
] ++ [
  # Disabled Packages
  # nixpkgs.fish
  # nixpkgs.iterm2
  # nixpkgs.starship
  # nixpkgs.terraform
  # nixpkgs.terraform-docs
  # nixpkgs.terragrunt
  # nixpkgs.vscode
] ++ (if nixpkgs.stdenv.isDarwin then [
  # Darwin Packages
  nixpkgs.cocoapods
  nixpkgs.reattach-to-user-namespace
] else [
])
