{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    # rustc
    # cargo
    # rust-analyzer
    # rustfmt
    # clippy
  ];
}
