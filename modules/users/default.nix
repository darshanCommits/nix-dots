{pkgs, ...}: {
  imports = [
    ./greeed.nix
  ];
  users = {
    defaultUserShell = pkgs.nushell;
  };
}
