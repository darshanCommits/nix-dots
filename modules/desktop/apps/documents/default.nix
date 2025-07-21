{pkgs, ...}: {
  imports = [
    ./file-manager.nix
  ];

  environment.systemPackages = with pkgs; [
    onlyoffice-bin
    zathura
    kdePackages.okular
  ];
}
