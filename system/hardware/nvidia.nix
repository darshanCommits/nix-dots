{
  config,
  pkgs,
  ...
}: {
  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      # sync.enable = true;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
