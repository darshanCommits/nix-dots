{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay
  ];
  environment.systemPackages = [
    pkgs.hyprpanel
  ];

  services.upower.enable = true;
  # services.blueman.enable = false;
}
