{ pkgs, ... }: {
  imports = [
    ./docker
    ./android
    ./direnv.nix
    ./formatter.nix
    ./languages.nix
    ./lsp.nix
    ./misc.nix
  ];

  environment.systemPackages = with pkgs; [
    act
    delta
    gh
    lazygit
    code-cursor
    android-studio
  ];
}
