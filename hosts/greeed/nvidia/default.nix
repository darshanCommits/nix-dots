{ pkgs, config, ... }:
let
  nvidiaPkg = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.124.04";
    sha256_64bit = "sha256-G3hqS3Ei18QhbFiuQAdoik93jBlsFI2RkWOBXuENU8Q=";
    sha256_aarch64 = "sha256-HN58N00SNEwMQKSKuOMAXVW6J2VI/2YyDulQNJHuVeM=";
    openSha256 = "sha256-KCGUyu/XtmgcBqJ8NLw/iXlaqB9/exg51KFx0Ta5ip0=";
    settingsSha256 = "sha256-LNL0J/sYHD8vagkV1w8tb52gMtzj/F0QmJTV1cMaso8=";
    persistencedSha256 = "sha256-SHSdnGyAiRH6e0gYMYKvlpRSH5KYlJSA1AJXPm7MDRk=";
  };
in
{
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  # environment.systemPackages = [ pkgs.gwe ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    # package = nvidiaPkg;

    modesetting.enable = true;
    nvidiaSettings = true;
    dynamicBoost.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
      sync.enable = false;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
