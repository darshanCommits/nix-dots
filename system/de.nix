# WAYLAND WAYLAND WAYLAND
{
  inputs,
  pkgs,
  ...
}: {
  # REFER: flake.nix TODO:1
  # imports = [
  #   inputs.gauntlet.nixosModules.default
  # ];

  # programs.gauntlet = {
  #   enable = true;
  #   service.enable = true;
  # };
  #

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
      xdg-desktop-portal-kde
    ];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  programs.kdeconnect = {
    enable = true;
  };
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

  services.xserver.displayManager.lightdm.enable = false;
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  security.polkit.enable = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.xserver.enable = true;
  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs;
    [
      # Util
      dbus-broker
      mako
      xwaylandvideobridge
      grimblast
      swaybg
      pavucontrol
      nwg-displays
      greetd.tuigreet
      plymouth
      gpu-screen-recorder

      # Theming
      dracula-icon-theme
      dracula-theme
      dracula-qt5-theme

      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugins
      kdePackages.qt6ct
      libsForQt5.qt5ct
      nwg-look

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
      inputs.pyprland.packages.${pkgs.system}.pyprland
      # Misc
      cmus
      audio-sharing
      wl-clipboard
      # hyprlandPlugins.hyprspace
      # hyprlandPlugins.hyprexpo
    ]
    ++ [
    ];

  # More info REFER: home.nix
}
