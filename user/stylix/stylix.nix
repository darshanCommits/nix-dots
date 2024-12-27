{
  pkgs,
  # wallpaper,
  ...
}: {
  stylix = {
    enable = true;
    image = ./goatv3.jpg;
    polarity = "dark";
    base16Scheme = ./dracula.yaml;

    cursor = {
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
      size = 24;
    };

    fonts = {
      sizes = {
        terminal = 14;
        desktop = 12;
        popups = 12;
        applications = 14;
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.ubuntu-sans;
        name = "Ubuntu Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      hyprland.enable = false;
      helix.enable = false;
      tofi.enable = false;
      # foot.enable = true;
      mako.enable = false;
      waybar.enable = false;
    };
  };
}
