{ config, pkgs, ... }: {
  stylix = {
    enable = false;
    autoEnable = true;
    image = config.wallpaper;
    base16Scheme = /. + config.colorscheme;
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
}
