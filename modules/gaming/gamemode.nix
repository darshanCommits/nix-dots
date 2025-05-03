{pkgs, ...}: {
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        inhibit_screensaver = 0;
        renice = 0; # Higher process priority
        ioprio = 0; # Highest I/O priority
      };
      gpu = {
        nv_powermizer_mode = 1; # needs coolbit set or a 570+ driver since it has it on by default
      };
    };
  };
}
