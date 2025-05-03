{...}: {
  imports = [
    ./nemo
    ./gauntlet
    ./browser.nix
    ./document.nix
    ./media.nix
    ./messaging.nix
    ./misc.nix
  ];

  security.polkit.enable = true;
  xdg.portal.enable = true;
}
