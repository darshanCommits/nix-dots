{
  inputs,
  pkgs,
  ...
}: let
  cargoTomlContent =
    # toml
    ''
      [build]
      # rustc-wrapper = "sccache"
      target-dir = "$HOME/.cargo/target"

      [target.x86_64-unknown-linux-gnu]
      linker = "clang"
      rustflags = ["-C", "link-arg=-fuse-ld=mold", "-C", "target-cpu=native"]
    '';
in {
  nixpkgs.overlays = [inputs.fenix.overlays.default];

  environment.systemPackages = with pkgs; [
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ])

    cargo-watch
    cargo-expand
    bacon
    mold-wrapped
    clang
  ];

  environment.etc."profile.d/rust-setup.sh".text =
    #sh
    ''
      export PATH="$HOME/.cargo/bin:$PATH"
      export CARGO_TARGET_DIR="$HOME/.cargo/target"
      export RUST_BACKTRACE=1

      CONFIG_FILE="$HOME/.cargo/config.toml"

      mkdir -p "$HOME/.cargo"
      cat > "$CONFIG_FILE" <<'EOF'
      ${cargoTomlContent}
      EOF

      # if [ ! -f "$CONFIG_FILE" ]; then
      # fi
    '';
}
