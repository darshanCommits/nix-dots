{pkgs, ...}: {
  imports = [
    ./wl-clipboard
    ./gui
    ./flatpak
    ./hypr
    ./kde
    ./stylix
  ];

  services.dbus = {
    apparmor = "enabled";
    implementation = "broker";
  };

  environment.systemPackages = with pkgs; [
    # Util
    xwaylandvideobridge
    grimblast
    swaybg
    pavucontrol
    nwg-displays
    gpu-screen-recorder-gtk
    tofi

    # Theming
    dracula-qt5-theme
    kdePackages.qtstyleplugin-kvantum

    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    # libsForQt5.kdeconnect-kde
    # kdePackages.kdeconnect-kde

    kdePackages.qt6ct
    libsForQt5.qt5ct
    nwg-look

    # ClipBoard

    # waybar
    cmus
    bitwarden
    foot
  ];
}
