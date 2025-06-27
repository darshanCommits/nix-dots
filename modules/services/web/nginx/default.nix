{ config, ... }:
let
  defaultProxyPass = port: "http://${config.localhost}:${toString port}";
  listener = {
    addr = config.localhost;
    port = config.port.nginx;
  };

  domains = {
    photos = "photos.${config.localDomain}";
    llm = "llm.${config.localDomain}";
    music = "music.${config.localDomain}";
  };
in
{
  networking.hosts = {
    "${config.localhost}" = builtins.attrValues domains;
    "${config.ip}" = builtins.attrValues domains;
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
      "${domains.photos}" = {
        listen = [ listener ];
        locations."/" = {
          proxyPass = defaultProxyPass config.port.immich;
          proxyWebsockets = true;
        };
      };

      "${domains.llm}" = {
        listen = [ listener ];
        locations."/" = {
          proxyPass = defaultProxyPass config.port.llmUi;
          proxyWebsockets = true;
        };
      };

      "${domains.music}" = {
        listen = [ listener ];
        locations."/" = {
          proxyPass = defaultProxyPass config.port.navidrome;
          proxyWebsockets = true;
          extraConfig = ''
            proxy_buffering off;
          '';
        };
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      config.port.nginx
      config.port.immich
      config.port.llmUi
      config.port.navidrome
    ];
  };
}
