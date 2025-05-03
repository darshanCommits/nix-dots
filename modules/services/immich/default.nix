{
  config,
  pkgs,
  ...
}: {
  services.immich = {
    enable = true;
    port = config.port.immich;
    host = config.localhost;
  };

  environment.systemPackages = with pkgs; [
    unstable.immich-go
  ];

  users.users.immich.extraGroups = ["video" "render"];
  # networking.firewall.allowedTCPPorts = [2283];
}
