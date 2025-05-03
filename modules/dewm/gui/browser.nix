{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.brave
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
