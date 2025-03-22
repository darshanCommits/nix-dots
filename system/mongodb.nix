{pkgs, ...}: {
  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };

  environment.systemPackages = with pkgs; [
    mongodb-compass
    mongosh
    mongodb-tools
  ];
}
