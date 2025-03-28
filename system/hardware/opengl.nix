{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}; # use when using hyprland git pkg
in {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };
  hardware.graphics = {
    enable = true;
    package = pkgs-unstable.mesa.drivers;
    # package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
    # enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl

      vulkan-tools
      vaapiVdpau
      libvdpau
      libvdpau-va-gl
      vdpauinfo
      libva
      libva-utils
    ];
  };
}
