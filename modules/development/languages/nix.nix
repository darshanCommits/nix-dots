{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Formatters
    nixpkgs-fmt

    # Language servers
    nil
    nixd
  ];
}
