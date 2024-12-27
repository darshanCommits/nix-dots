{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.packages = with pkgs; (
    let
      basePkgs = [
        # base
        wineWowPackages.stable
        inputs.umu.packages.${pkgs.system}.umu
        protonup
      ];
      launcherPkgs = [
        # Launchers
        heroic
        lutris
        itch
        bottles-unwrapped
      ];
    in
      basePkgs ++ launcherPkgs
  );
}
