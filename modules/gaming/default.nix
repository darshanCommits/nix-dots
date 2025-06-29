{ pkgs
, config
, ...
}: {
  imports = [
    ./gamemode
    ./proton
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam;
  };

  environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${config.homeDir}/.steam/root/compatibilitytools.d";
}
