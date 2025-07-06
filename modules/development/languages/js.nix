{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    typescript
    deno
    nodejs
    pnpm

    biome
    emmet-language-server
    tailwindcss-language-server
    typescript-language-server
    vscode-langservers-extracted
  ];
}
