{
  config,
  pkgs,
  ...
}: {
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;
}
