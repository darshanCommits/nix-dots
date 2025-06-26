{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    just-formatter
    google-java-format
    shfmt
    nixpkgs-fmt
    biome
  ];
}
