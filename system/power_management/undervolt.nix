{
  config,
  pkgs,
  ...
}: {
  services.undervolt = {
    enable = true;
    coreOffset = -165;
    turbo = 0;
    verbose = true;
  };
}
