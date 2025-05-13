{config, ...}: let
  servicesList = config.serviceDomains;
  orDefault = x: default:
    if x != null
    then x
    else default;

  defaultProxyPass = port: "http://${config.localhost}:${toString port}";
  defaultLocation = "/";
in {
  services.nginx.virtualHosts = builtins.listToAttrs (map (x: {
      name = "${x.name}.${config.localDomain}";
      value = {
        locations."${orDefault x.location defaultLocation}" = {
          proxyPass = (defaultProxyPass x.port) + (orDefault x.proxyPass "");
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
      };
    })
    servicesList);
}
