{...}: {
  imports = [
    ./auto-cpufreq.nix
    ./undervolt.nix
  ];

  services.power-profiles-daemon.enable = false;
}
