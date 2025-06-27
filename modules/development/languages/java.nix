{ pkgs, ... }: {
  programs.java.enable = true;

  environment.systemPackages = with pkgs; [
    # Java Development Kit
    jdk

    # Formatters
    google-java-format

    # Language server
    jdt-language-server
  ];
}
