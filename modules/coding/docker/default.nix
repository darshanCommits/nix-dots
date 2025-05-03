{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.greeed = {
    isNormalUser = true;
    extraGroups = ["podman"];
  };

  environment.systemPackages = [pkgs.distrobox];
}
