{
  pkgs,
  HOME,
  ...
}: {
  programs = {
    gamescope = {
      enable = true;
      package = pkgs.gamescope;
      capSysNice = true;
      args = [
        "--force-grab-cursor" # Better cursor handling
        "--borderless" # Removes window decorations
        "--fullscreen" # Forces fullscreen mode
      ];
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          inhibit_screensaver = 0;
          renice = 0; # Higher process priority
          ioprio = 0; # Highest I/O priority
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          nv_powermizer_mode = 1; # needs coolbit set or a 570+ driver since it has it on by default
        };
        custom = {
          start = ''
            #!/usr/bin/env bash
            # makoctl mode -s dnd
            hyprctl --batch "\
                keyword animations:enabled 0;\
                keyword decoration:shadow:enabled 0;\
                keyword decoration:blur:enabled 0;\
                keyword general:gaps_in 0;\
                keyword general:gaps_out 0;\
                keyword general:border_size 1;\
                keyword decoration:rounding 0"

            notify-send "GameMode" "Performance mode enabled"
          '';
          end = ''
            #!/usr/bin/env bash
            # makoctl mode -r dnd
            hyprctl reload
            notify-send "GameMode" "Performance mode disabled"
          '';
        };
      };
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam;
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    # base, things wont work properly without these
    unstable.umu-launcher
    gamemode
    gamescope
    mangohud
    protontricks
    protonup
    winetricks
    wineWowPackages.stable

    # Launchers
    heroic-unwrapped
    lutris-unwrapped
    bottles-unwrapped
    itch
  ];
}
