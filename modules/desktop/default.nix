{ pkgs, ... }: {
  imports = [
    ./environments
    ./flatpak
    ./apps
    ./fonts
    ./services
  ];

  environment.systemPackages = with pkgs;[
    cliphist
    swaybg
    tofi
    hyprpicker

    (
      unstable.quickshell
      #   .override {
      #   withJemalloc = true;
      #   withQtSvg = true;
      #   withWayland = true;
      #   withX11 = false;
      #   withPipewire = true;
      #   withPam = true;
      #   withHyprland = true;
      #   withI3 = false;
      # }
    )
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative

  ];
}
