{pkgs, ...}: {
  imports = [
    ./environments/niri
    ./environments/kde
    ./apps
    ./fonts
    ./services
  ];

  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    tofi
    hyprpicker
  ];
}
