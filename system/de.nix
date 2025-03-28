# WAYLAND WAYLAND WAYLAND
{
  HOME,
  inputs,
  pkgs,
  lib,
  ...
}: {
  services.displayManager.ly.enable = true;
  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.image = ./../assets/wallpapers/goatv3.jpg;
  stylix.base16Scheme = ./../assets/dracula.yaml;

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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_PICTURES_DIR = "${HOME}/Pictures";
    XDG_SCREENSHOTS_DIR = "${HOME}/Pictures/Screenshots";
  };

  hardware.brillo.enable = true;

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.upower.enable = true;

  programs.uwsm = {
    enable = true;
  };
  programs.hyprland = {
    enable = true;
    # set the flake package
    # # make sure to also set the portal package, so that they are in sync
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.system}.hypridle;
  };
  programs.hyprlock = {
    enable = true;
    package = pkgs.unstable.hyprlock;
  };

  #TODO: xdg.portal.config / common default / whatever.
  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk
    #   xdg-desktop-portal-kde
    # ];
    # config.common.default = ["*"];
  };

  qt = {
    enable = true;
    # style = "kvantum";
  };

  # more buggy than home manager module
  # programs.kdeconnect = {
  #   enable = true;
  # };
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  services.desktopManager.plasma6.enable = false;
  services.displayManager.sddm.enable = false;

  services.xserver = {
    enable = true;

    windowManager = {
      openbox.enable = false;
    };
    desktopManager = {
      xfce.enable = false;
    };
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    # Util
    dbus-broker
    xwaylandvideobridge
    grimblast
    swaybg
    pavucontrol
    nwg-displays
    greetd.tuigreet
    unstable.gpu-screen-recorder-gtk

    # Theming
    dracula-icon-theme
    dracula-theme
    dracula-qt5-theme
    kdePackages.qtstyleplugin-kvantum

    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    # libsForQt5.kdeconnect-kde
    # kdePackages.kdeconnect-kde

    kdePackages.qt6ct
    libsForQt5.qt5ct
    unstable.nwg-look

    # ClipBoard
    cliphist
    wl-clipboard
    wtype

    # Hyprland ecosystem
    unstable.hyprpicker
    unstable.pyprland
    # hyprpolkitagent
    hyprpanel

    # Misc
    waybar
    cmus
    unstable.anyrun
    bitwarden

    # file manager
    nemo
    nemo-python
    nemo-fileroller
    nemo-emblems
  ];

  # More info REFER: home.nix
}
