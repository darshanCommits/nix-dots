{ pkgs, ... }: {
  imports = [
    ./kdeconnect
    ./nginx
  ];
  networking.networkmanager.enable = true;

  environment.systemPackages = [
    pkgs.openssl
  ];
}
