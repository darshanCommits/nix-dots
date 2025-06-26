{ config, ... }:
let
  defaultProxyPass = port: "http://${config.localhost}:${toString port}";
in
{
  services.nginx.virtualHosts = {
    "photos.${config.localDomain}" = {
      listen = [
        { addr = config.localhost; port = config.port.nginx; }
      ];
      locations."/" = {
        proxyPass = defaultProxyPass config.port.immich;
        proxyWebsockets = true;
      };
    };

    "llm.${config.localDomain}" = {
      listen = [
        { addr = config.localhost; port = config.port.nginx; }
      ];
      locations."/" = {
        proxyPass = defaultProxyPass config.port.llmUi;
        proxyWebsockets = true;
      };
    };

    "music.${config.localDomain}" = {
      listen = [
        { addr = config.localhost; port = config.port.nginx; }
      ];
      locations."/" = {
        proxyPass = defaultProxyPass config.port.navidrome;
        proxyWebsockets = true;
      };
    };
  };
}
