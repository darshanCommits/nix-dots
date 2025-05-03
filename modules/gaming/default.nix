{
  pkgs,
  HOME,
  ...
}: {
  imports = [
    ./gamemode.nix
    ./pkgs.nix
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam;
  };

  environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${HOME}/.steam/root/compatibilitytools.d";
}
