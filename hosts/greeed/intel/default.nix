{ pkgs, ... }: {
  config = {
    boot.initrd.kernelModules = [ "i915" ];

    hardware.graphics.extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
    ];

    hardware.graphics.extraPackages32 = with pkgs; [
      driversi686Linux.intel-media-driver
    ];
  };
}
