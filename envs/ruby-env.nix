let
  pkgs = import <nixpkgs> {};
in [
  pkgs.ruby_3_2
  (pkgs.ruby_3_2.withPackages
    (ps: with ps;
      [
        pg
        rails
      ]
    )
  )
]
