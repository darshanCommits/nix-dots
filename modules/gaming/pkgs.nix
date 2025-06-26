{ pkgs, ... }: {


  environment.systemPackages = with pkgs; [
    mangohud
    protontricks
    winetricks
    wineWowPackages.stable
    umu-launcher

    # Launchers
    heroic
    lutris
    bottles
    itch
  ];
}
