{
  config,
  pkgs,
  ...
}: {
  services.undervolt = {
    enable = true;
    coreOffset = -150;
    turbo = 0;
    verbose = true;
  };
}
