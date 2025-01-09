{
  pkgs,
  HOME,
  ...
}: {
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${HOME}/.steam/root/compatibilitytools.d";
  };

  environment.systemPackages = with pkgs; [
    # base
    wineWowPackages.stable
    protonup
    gamescope
    mangohud

    # Launchers
    heroic-unwrapped
    lutris-unwrapped
    itch
  ];
}
