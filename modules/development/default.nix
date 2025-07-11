{pkgs, ...}: {
  imports = [
    # ./tools/kvm
    ./tools/docker

    ./adb
    ./languages
  ];

  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    enableBashIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  # Global sccache configuration
  environment.variables = {
    SCCACHE_DIR = "$HOME/.cache/sccache";
    RUSTC_WRAPPER = "sccache";
    CC = "sccache gcc";
    CXX = "sccache g++";
  };

  environment.systemPackages = with pkgs; [
    # editors
    vim

    # Version control and Git tools
    act

    # Build caching and utilities
    cachix
    # devenv
    sccache
    mold-wrapped
  ];
}
