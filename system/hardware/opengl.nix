{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa.drivers
      libvdpau-va-gl
      vaapiIntel
      intel-media-driver
    ];
  };
}
