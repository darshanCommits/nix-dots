{pkgs, ...}: {
  imports = [
    ./docker
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
    unstable.code-cursor
  ];
}
