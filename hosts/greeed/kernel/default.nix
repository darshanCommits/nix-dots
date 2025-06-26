{ pkgs, ... }: {
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };


  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
