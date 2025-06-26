{ config, ... }: {
  config.serviceDomains = [
    {
      name = "photos";
      port = config.port.immich;
    }
    {
      name = "llm";
      port = config.port.llmUi;
    }
    {
      name = "music";
      port = config.port.navidrome;
      extraConfig = ''
        proxy_buffering off;
      '';
    }
  ];
}
