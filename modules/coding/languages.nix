{ inputs
, pkgs
, ...
}: {
  programs.java.enable = true;
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    go
    nodejs
    pnpm
    deno
    typescript
    jdk
    gcc
    python3
    cmake
    meson
    cpio
    cmake
    just
    (rust-bin.stable.latest.default.override
      {
        extensions = [ "rust-analyzer" "rust-src" ];
      })
  ];
}
