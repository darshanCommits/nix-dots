{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Formatters
    nixpkgs-fmt
    alejandra

    # Language servers
    nil
    nixd
  ];
}
