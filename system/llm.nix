{...}: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    loadModels = [
      # "deepseek-r1:7b"
      "deepseek-r1:8b"
      # "deepseek-r1:14b"
    ];
  };

  services.open-webui = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    port = 1234;
    environment = {
      WEBUI_AUTH = "False";
    };
  };
}
