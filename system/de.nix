# WAYLAND WAYLAND WAYLAND
{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
      # Browser-related MIME types
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];
      "x-scheme-handler/mailto" = ["brave-browser.desktop"];
      "text/html" = ["brave-browser.desktop"];

      # Image files to open with feh
      "image/png" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];
      "image/bmp" = ["feh.desktop"];
      "image/tiff" = ["feh.desktop"];
      "image/svg+xml" = ["feh.desktop"];

      # Video and audio files to open with mpv
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];

      # Text files to open with Helix
      "text/plain" = ["Helix.desktop"];
      "text/xml" = ["Helix.desktop"];
      "application/json" = ["Helix.desktop"];
      "text/x-shellscript" = ["Helix.desktop"];
      "application/x-sh" = ["Helix.desktop"];
      "text/css" = ["Helix.desktop"];
      "application/x-yaml" = ["Helix.desktop"];
      "application/x-tar" = ["Helix.desktop"];

      # PDF files to open with Zathura
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];

      # File manager for directories
      "inode/directory" = ["thunar.desktop"];

      # Terminal: foot for terminal applications
      "x-scheme-handler/terminal" = ["foot.desktop"];

      # Telegram desktop application handlers
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
    };
  };

  services.displayManager.ly.enable = true;
  security.polkit.enable = true;
  security.pam.services.ly.enableGnomeKeyring = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.xserver.enable = false;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; (
    [
      # Generic
      mako
      xwaylandvideobridge
      waybar
      grimblast
      swaybg
      pavucontrol
    ]
    ++ [
      # Theming

      libsForQt5.qtstyleplugin-kvantum
    ]
    ++ [
      # ClipBoard

      cliphist
      wl-clipboard
      wtype
    ]
    ++ [
      # Hyprland ecosystem

      hyprpicker
      hyprcursor
      hyprlock
      hyprpaper
    ]
  );
}
