# WAYLAND WAYLAND WAYLAND
{
  inputs,
  pkgs,
  ...
}: {
  boot = {
    # Override other boot settings
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader.timeout = 2;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.uwsm = {
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  services.xserver.displayManager.lightdm.enable = false;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  security.polkit.enable = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.xserver.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  # Thunar config
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs; [
    # Util
    dbus-broker
    mako
    xwaylandvideobridge
    grimblast
    swaybg
    pavucontrol
    nwg-look
    nwg-displays
    greetd.tuigreet
    plymouth
    gpu-screen-recorder

    # Theming
    dracula-icon-theme
    dracula-qt5-theme
    dracula-theme
    libsForQt5.qtstyleplugin-kvantum

    # ClipBoard
    cliphist
    wl-clipboard
    wtype

    # Hyprland ecosystem
    hyprpicker
    hyprcursor
    hyprlock
    hyprpaper
    hyprpolkitagent

    # Misc
    cmus
    hyprlandPlugins.hyprspace
    hyprlandPlugins.hyprexpo
  ];
}
