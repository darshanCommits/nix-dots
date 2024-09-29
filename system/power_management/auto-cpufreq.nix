{
  config,
  pkgs,
  ...
}: {
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "balanced";
      turbo = "auto";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
