{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    google-java-format
    shfmt
    alejandra
    biome
  ];
}
