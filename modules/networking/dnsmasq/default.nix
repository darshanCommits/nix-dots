{config, ...}: {
  services.dnsmasq = {
    enable = false;
    settings = {
      domain-needed = true;
      bogus-priv = true;

      server = [
        "1.1.1.1"
      ];

      listenAddress = [config.loopbackAddress config.ip];

      address = [
        "/photos.${config.localDomain}/${config.ip}"
        "/music.${config.localDomain}/${config.ip}"
        "/llm.${config.localDomain}/${config.ip}"
        # "/greeed.local/${config.ip}"
      ];
    };
  };
}
