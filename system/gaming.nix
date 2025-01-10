{
  inputs,
  pkgs,
  HOME,
  ...
}: let
  umu = inputs.umu.packages.${pkgs.system}.umu.override {
    version = inputs.umu.shortRev;
    truststore = true;
    cbor2 = true;
  };
in {
  programs = {
    gamemode = {
      enable = true;
      settings = {
        general.inhibit_screensaver = 0;
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            gamemode
          ];
      };
    };
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = [
    # base, things wont work properly without these
    umu
    pkgs.wineWowPackages.stable
    pkgs.protonup
    pkgs.gamescope
    pkgs.mangohud

    # Launchers
    pkgs.heroic-unwrapped
    pkgs.lutris-unwrapped
    pkgs.itch
  ];
}
