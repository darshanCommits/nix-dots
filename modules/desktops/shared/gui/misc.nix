{ pkgs, ... }: {
  networking.firewall.allowedTCPPorts = [ 53317 ];
  environment.systemPackages = with pkgs; [
    localsend
    qbittorrent
    renpy
    nicotine-plus
    gparted
    hyprpicker
  ];
}
