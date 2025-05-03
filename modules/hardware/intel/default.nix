{pkgs, ...}: let
  intel-media-driver = pkgs.intel-media-driver;
  intel-media-driver-32 = pkgs.driversi686Linux.intel-media-driver;
  intel-compute-runtime = pkgs.intel-compute-runtime;
  vpl-gpu-rt = pkgs.vpl-gpu-rt or pkgs.onevpl-intel-gpu;
in {
  config = {
    boot.initrd.kernelModules = ["i915"];

    hardware.graphics.extraPackages = [
      intel-media-driver
      intel-compute-runtime
      vpl-gpu-rt
    ];

    hardware.graphics.extraPackages32 = [
      intel-media-driver-32
    ];
  };
}
