{
  config,
  inputs,
  pkgs,
  ...
}: {
  
  environment.systemPackages = with pkgs; [
    # Languages
      go
      nodejs
      typescript
      jdk
      gcc
    python3
     # LSP
      nil
      nodePackages.bash-language-server
      typescript-language-server
      emmet-language-server
      vscode-langservers-extracted
      ccls
      cmake
      pest-ide-tools
      shellcheck
      nixd
      taplo
    hyprls
      
    
     # Formatters
      
    shfmt
    alejandra # nix formatter
    ];
}

