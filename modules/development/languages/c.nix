{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Compilers and build tools
    gcc
    cmake
    meson
    cpio

    # Language servers and tooling
    ccls
    libclang

    # Build optimization
    mold-wrapped
  ];

  # Setup mold as default linker for C/C++
  environment.variables = {
    LDFLAGS = "-fuse-ld=mold";
    CFLAGS = "-march=native -O2 -pipe -fuse-ld=mold";
    CXXFLAGS = "-march=native -O2 -pipe -fuse-ld=mold";
  };

  # Create mold wrapper scripts
  environment.etc."profile.d/c-setup.sh".text =
    # sh
    ''
      # Setup mold for various build systems
      export CMAKE_C_FLAGS="$CMAKE_C_FLAGS -fuse-ld=mold"
      export CMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -fuse-ld=mold"
      export MESON_ARGS="--buildtype=release -Db_lto=true"
    '';
}
