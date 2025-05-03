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

  # networking.firewall.allowedTCPPorts =
  #   (map (s: s.port) servicesList)
  #   ++ [
  #     config.port.nginx
  #   ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;

    # commonHttpConfig = ''
    #   proxy_headers_hash_max_size 1024;
    #   proxy_headers_hash_bucket_size 128;
    # '';

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
