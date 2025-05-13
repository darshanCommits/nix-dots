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
    package = pkgs.unstable.ollama;
    host = config.localhost;
    acceleration = "cuda";
  };
}
