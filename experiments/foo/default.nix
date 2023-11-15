{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        aspell
        bc
        coreutils
        gdb
        ffmpeg
        nixUnstable
        emscripten
        jq
        nox
        silver-searcher
      ];
    };
  };
}
