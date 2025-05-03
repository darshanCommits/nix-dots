{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mangohud
    protontricks
    winetricks
    wineWowPackages.stable
    unstable.umu-launcher

    # Launchers
    heroic
    lutris
    bottles
    itch
  ];
}
