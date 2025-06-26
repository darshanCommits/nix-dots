{ ... }: {
  services.mako = {
    enable = true;
    settings = builtins.readFile ./config;
  };
}
