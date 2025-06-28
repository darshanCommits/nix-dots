{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    wl-clipboard
  ];
  imports = [
    ./hyprland
    ./kde
    ./niri
  ];

}
