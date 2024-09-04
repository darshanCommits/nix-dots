{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
      taplo
      hyprls
      rust-analyzer
      alejandra # nix formatter
      nixd
      nil
      nodePackages.bash-language-server
      ccls

      # web
      biome
      typescript-language-server
      emmet-language-server
      vscode-langservers-extracted
    ];

	}
