{pkgs, ...}: {
  imports = [
    ./c.nix
    ./java.nix
    ./rust.nix
    ./go.nix
    ./nix.nix
    ./js.nix
    # ./python.nix
  ];

  # Others
  environment.systemPackages = with pkgs; [
    nodePackages.bash-language-server
    harper
    markdown-oxide
    just-lsp
    just
  ];
}
