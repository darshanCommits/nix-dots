{}: {
  services.auto-cpufreq = {
    enable = true;
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "powersave";
      turbo = "auto";
    };
  };
}
