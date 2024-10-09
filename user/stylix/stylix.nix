{
  pkgs,
  ...
}:   let  
    wallpaper = /home/greeed/.dotfiles/assets/wallpapers/goatv3.jpg;
  in {

  stylix = {
    enable = true;
    image = wallpaper;
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
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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
      foot.enable = false;
    };
  };
}
