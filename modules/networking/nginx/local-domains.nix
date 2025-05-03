{config, ...}: let
  servicesList = config.serviceDomains;
  orDefault = x: default:
    if x != null
    then x
    else default;

  defaultProxyPass = port: "http://${config.localhost}:${toString port}";
  defaultLocation = "/";
  # defaultExtraConfig = ''
  #   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  #   proxy_set_header X-Forwarded-Host $http_host;
  #   proxy_set_header X-Forwarded-Proto $scheme;
  #   proxy_set_header X-Forwarded-Protocol $scheme;
  #   proxy_set_header X-Real-IP $remote_addr;
  # '';
in {
  services.nginx.virtualHosts = builtins.listToAttrs (map (x: {
      name = "${x.name}.${config.localDomain}";
      value = {
        locations."${orDefault x.location defaultLocation}" = {
          proxyPass = (defaultProxyPass x.port) + (orDefault x.proxyPass "");
          proxyWebsockets = true;
        };
      };
    })
    servicesList);
}
