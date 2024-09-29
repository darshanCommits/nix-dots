{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # modesetting = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau
      libvdpau-va-gl
      vdpauinfo
      vaapiIntel
      libva
      libva-utils
      intel-media-driver
    ];
  };
}
