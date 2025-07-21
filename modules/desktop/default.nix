{pkgs, ...}: {
  imports = [
    ./environments/niri
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
