{
  pkgs,
  config,
  ...
}: {
  services.open-webui = {
    enable = true;
    host = config.localhost;
    port = config.port.llmUi;
    # package = pkgs.unstable.open-webui;
    openFirewall = false;
    environment.WEBUI_AUTH = "False";
  };
}
