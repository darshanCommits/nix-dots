{ pkgs, ... }: {
  imports = [
    ./environments
    ./flatpak
    ./apps
    ./fonts
    ./services
  ];
  environment.systemPackages = with pkgs;[
    cliphist
  ];
}
