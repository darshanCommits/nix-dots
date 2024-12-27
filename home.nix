{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./system/stylix.nix
  ];

  home.username = "greeed";
  home.homeDirectory = "/home/greeed";

  xresources.properties = {
    "Xcursor.size" = 24;
    # "Xft.dpi" = 172;
  };

  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ./../assets/wallpapers/goatv3.jpg;

  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  config.lib.stylix.colors = {
    base00 = "#0D1117";
  };

  stylix.cursor = {
    package = pkgs.dracula-theme;
    name = "Dracula-cursors";
    size = 24;
  };

  stylix.targets = {
    hyprland.enable = false;
    helix.enable = false;
    tofi.enable = false;
    foot.enable = false;
    mako.enable = false;
    waybar.enable = false;
  };

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
