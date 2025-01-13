{
  pkgs,
  lib,
  inputs,
  # HOME,
  ...
}: {
  # imports = [
  #   ./config
  # ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # Adapt this to the current Home Manager version
  home.username = "greeed";
  home.homeDirectory = "/home/greeed";
  home.enableNixpkgsReleaseCheck = false;

  # SYMLINKING DOTS
  home.file = {
    ".config/hypr" = {source = ./config/hypr; recursive = true;};
    ".config/mpv" = {source = ./config/mpv; recursive = true;};
    ".config/helix" = {source = ./config/helix; recursive = true;};
    ".config/zathura" = {source = ./config/zathura; recursive = true;};
    ".config/git" = {source = ./config/git; recursive = true;};
    ".config/nushell" = {source = ./config/nushell; recursive = true;};
  };

  services.easyeffects.enable = true;

  stylix = {
    enable = true;
    autoEnable = true;
    image = ./assets/wallpapers/goatv3.jpg;

    polarity = "dark";
    base16Scheme = {
      base00 = "0D1117";
      base01 = "3a3c4e";
      base02 = "4d4f68";
      base03 = "626483";
      base04 = "62d6e8";
      base05 = "e9e9f4";
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2";
      base09 = "b45bcf";
      base0A = "00f769";
      base0B = "ebff87";
      base0C = "a1efe4";
      base0D = "62d6e8";
      base0E = "b45bcf";
      base0F = "00f769";
    };

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
