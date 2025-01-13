{
  config,
  inputs,
  pkgs,
  ...
}: {
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

    # LSP
    nixd
    nil
    nodePackages.bash-language-server
    typescript-language-server
    emmet-language-server
    vscode-langservers-extracted
    ccls
    cmake
    pest-ide-tools
    shellcheck
    taplo
    hyprls
    rustup

    # Formatters

    shfmt
    alejandra # nix formatter
    biome

    # Misc
    mold
    cachix
    devenv
  ];
}
