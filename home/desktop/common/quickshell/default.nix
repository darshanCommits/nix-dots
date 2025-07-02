{ inputs, pkgs, lib, ... }:
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.quickshell;
in
{
  home.packages = with pkgs; [
    kdePackages.qqc2-desktop-style
    kdePackages.qt5compat
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.sonnet
    libsForQt5.qt5.qtgraphicaleffects
    pkgs.kdePackages.kirigami.passthru.unwrapped

    qt6Packages.qt5compat
    qt6.qt5compat
    qt6.qtdeclarative
    quickshell
  ];

  home.sessionVariables.QML2_IMPORT_PATH = lib.concatStringsSep ":" [
    "${quickshell}/lib/qt-6/qml"
    "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    "${pkgs.kdePackages.kirigami.unwrapped}/lib/qt-6/qml"
    "${pkgs.qt6.qt5compat}/${pkgs.qt6.qtbase.qtQmlPrefix}"
    "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}"
  ];
}
