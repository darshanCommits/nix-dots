{
  config,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement = {
      enable = false;
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

  environment.variables = {
    GBM_BACKEND = "nvidia";
    NVD_BACKEND = "direct";
  };

  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
  ];

  # programs.zsh.shellAliases = {
  #   mpv = "nvidia-offload mpv";
  #   stremio = "nvidia-offload stremio";
  #   brave = "nvidia-offload brave";
  # };
}
