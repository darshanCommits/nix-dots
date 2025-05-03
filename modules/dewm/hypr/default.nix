{
  inputs,
  pkgs,
  ...
}: let
  unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    ./hyprpanel.nix
    ./brightness.nix
  ];

  # hardware.graphics = {
  #   package = unstable.mesa.drivers;
  #   package32 = unstable.pkgsi686Linux.mesa.drivers;
  # };
  # programs.hyprland = {
  # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.hypridle = {
    enable = true;
  };
}
