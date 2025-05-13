{
  pkgs,
  inputs,
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
      # policies = {
      #   DisableAppUpdate = true;
      #   DisableTelemetry = true;
      #   AutofillAddressEnabled = true;
      #   AutofillCreditCardEnabled = false;
      #   DisableFeedbackCommands = true;
      #   DisableFirefoxStudies = true;
      #   DisablePocket = true;
      #   DontCheckDefaultBrowser = true;
      #   NoDefaultBookmarks = true;
      #   OfferToSaveLogins = false;
      # };
    };
in {
  # imports = [
  #   inputs.zen-browser.homeModules.default
  # ];

  home.packages = [zen];

  # programs.zen-browser = {
  #   enable = true;
  #   nativeMessagingHosts = with pkgs; [
  #     firefoxpwa
  #     ff2mpv-rust
  #     bitwarden-desktop
  #   ];
  #   policies = {
  #     DisableAppUpdate = true;
  #     DisableTelemetry = true;
  #     AutofillAddressEnabled = true;
  #     AutofillCreditCardEnabled = false;
  #     DisableFeedbackCommands = true;
  #     DisableFirefoxStudies = true;
  #     DisablePocket = true;
  #     DontCheckDefaultBrowser = true;
  #     NoDefaultBookmarks = true;
  #     OfferToSaveLogins = false;
  #   };
  # };
}
