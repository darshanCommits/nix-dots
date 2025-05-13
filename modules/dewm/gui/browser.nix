{
  inputs,
  pkgs,
  ...
}: let
  zen =
    inputs.zen-browser.packages."${pkgs.system}".twilight.override
    {
      nativeMessagingHosts = with pkgs; [
        firefoxpwa
        ff2mpv-rust
        bitwarden-desktop
      ];
    };
in {
  environment.systemPackages = [
    pkgs.brave
    zen
    pkgs.ff2mpv-rust
    pkgs.firefoxpwa
  ];
}
