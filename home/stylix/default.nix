{ config
, pkgs
, ...
}: {
  qt.enable = true;
  gtk.enable = true;

  stylix = {
    enable = false;
    autoEnable = true;
    image = ./../../assets/images/goatv3.jpg;
    base16Scheme = ./../../assets/colorscheme.yaml;
    polarity = "dark";

    cursor = {
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.dracula-icon-theme;
      dark = "Dracula";
      light = "Dracula";
    };
  };

  # stylix.fonts = {
  #   serif = {
  #     package = pkgs.dejavu_fonts;
  #     name = "DejaVu Serif";
  #   };

  #   sansSerif = {
  #     name = "Ubuntu Sans";
  #     package = pkgs.ubuntu-sans;
  #   };

  #   monospace = {
  #     package = pkgs.nerd-fonts.jetbrains-mono;
  #     name = "JetBrains Mono";
  #   };

  #   emoji = {
  #     package = pkgs.noto-fonts-emoji;
  #     name = "Noto Color Emoji";
  #   };
  # };
}
