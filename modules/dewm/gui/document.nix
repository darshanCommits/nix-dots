{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-bin
    zathura
  ];
}
