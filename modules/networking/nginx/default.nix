{ config, ... }:
let

  domainList = map (name: "${name}.${config.localDomain}") subdomains;
  subdomains = map (s: s.name) servicesList;
  ports = map (s: s.port) servicesList;
  servicesList = config.serviceDomains;
in
{
  imports = [
    ./local-domains.nix
  ];
  networking.hosts = {
    "${config.localhost}" = domainList;
    "${config.ip}" = domainList; # Replace with your actual IP

  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    defaultListen = [
      {
        addr = "${config.localhost}";
        port = config.port.nginx;
      }
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ config.port.nginx ] ++ ports;
  };

}
