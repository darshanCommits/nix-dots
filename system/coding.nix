{
  config,
  inputs,
  pkgs,
  ...
}: {
  # nixpkgs.overlays = [fenix.overlays.default];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = false;
  };

  programs.java.enable = true;
  environment.systemPackages = with pkgs; [
    # Languages
    go
    nodejs
    typescript
    jdk
    gcc
    python3
    cmake
    meson
    cpio
    cmake
    (rust-bin.stable.latest.default.override
      {
        extensions = ["rust-analyzer" "rust-src"];
      })

    # LSP
    tailwindcss-language-server
    unstable.jdt-language-server
    libclang
    nixd
    nil
    nodePackages.bash-language-server
    typescript-language-server
    emmet-language-server
    vscode-langservers-extracted
    ccls
    pest-ide-tools
    shellcheck
    taplo
    unstable.hyprls
    harper
    markdown-oxide

    # Formatters
    google-java-format
    shfmt
    alejandra # nix formatter
    biome

    # Misc
    mold-wrapped
    sccache
    cachix
    devenv
  ];
}
