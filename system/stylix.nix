{
  config,
  inputs,
  pkgs,
  ...
}: {
  stylix.enable = true;
  stylix.image = ./../assets/wallpapers/goatv3.jpg;

  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  config.lib.stylix.colors = {
    base00= "#0D1117";
  };

  stylix.fonts = {
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
      package = pkgs.jetbrains-mono;
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

}

