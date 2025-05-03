{pkgs, ...}: {
  imports = [
    # ./dnsmasq
    ./nginx
  ];
  networking.networkmanager.enable = true;

  environment.systemPackages = [
    pkgs.openssl
  ];
}
