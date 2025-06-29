{ inputs, pkgs, ... }:

let helix = inputs.helix-driver.packages.${pkgs.system}.helix; in {
  imports = [
    # ./tools/kvm
    ./tools/docker

    ./adb
    ./languages
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = false;
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
    helix # this will be pulled from our let bind. that's how nix works??

    # Version control and Git tools
    act
    delta
    gh
    lazygit

    # Build caching and utilities
    cachix
    # devenv
    sccache
    mold-wrapped
  ];
}
