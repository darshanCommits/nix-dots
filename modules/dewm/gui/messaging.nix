{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unstable.zapzap
    telegram-desktop
    vesktop
    element-desktop
    thunderbird-latest
  ];
}
