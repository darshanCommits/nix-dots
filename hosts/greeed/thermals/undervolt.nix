{...}: let
  undervolt_mV = -125;
in {
  services.undervolt = {
    enable = true;
    coreOffset = undervolt_mV;
    turbo = 0;
  };
}
