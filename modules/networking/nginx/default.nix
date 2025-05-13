{config, ...}: let
  domainList = map (name: "${name}.${config.localDomain}") subdomains;
  subdomains = map (s: s.name) servicesList;
  servicesList = config.serviceDomains;
in {
  imports = [
    ./local-domains.nix
  ];
  networking.hosts = {
    "${config.localhost}" = domainList;
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

    virtualHosts = {
      "_" = {
        default = true;
        locations."/" = {
          return = "404";
        };
      };
    };
  };
}
