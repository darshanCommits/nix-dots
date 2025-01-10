{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    prime = {
      sync.enable = true;
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ];
}
