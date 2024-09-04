{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
  ];
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
}
