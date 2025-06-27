{ pkgs, ... }: {
  services.atuin = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    atuin
  ];
}
