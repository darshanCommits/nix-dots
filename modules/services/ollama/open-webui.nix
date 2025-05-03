{
  lib,
  config,
  ...
}: {
  services.open-webui = {
    enable = true;
    host = config.localhost;
    port = config.port.llmUi;
    openFirewall = false;
    environment.WEBUI_AUTH = "False";
  };
}
