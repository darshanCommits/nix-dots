{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
  imports = [
    # ./hyprland
    ./cosmic
    ./kde
    ./niri
  ];
}
