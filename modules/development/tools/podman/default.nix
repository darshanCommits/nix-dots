{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # aliases
    defaultNetwork.settings.dns_enabled = true;
  };

  users.users.greeed = {
    isNormalUser = true;
    extraGroups = [ "podman" ];
  };

  environment.systemPackages = [ pkgs.distrobox ];
}
