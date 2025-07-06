{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./open-webui.nix
  ];
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
    host = config.localhost;
    acceleration = "cuda";
  };
}
