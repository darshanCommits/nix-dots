{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    just-lsp
    tailwindcss-language-server
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
    hyprls
    harper
    markdown-oxide
    jdt-language-server
  ];
}
