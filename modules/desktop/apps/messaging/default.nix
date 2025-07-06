{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zapzap
    telegram-desktop
    thunderbird-latest
  ];
}
