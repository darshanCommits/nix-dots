{
  config,
  pkgs,
  ...
}: let
  max_freq = 3800000;
in {
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        # scaling_max_freq = max_freq;
        # enable_thresholds = true;
        # stop_threshold = 85;
      };
      charger = {
        # scaling_max_freq = max_freq;
      };
    };
  };
}
