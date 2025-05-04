{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    # inputs.zen-browser.homeModules.beta
    # or inputs.zen-browser.homeModules.twilight-official
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      firefoxpwa
      ff2mpv-rust
      bitwarden-desktop
    ];
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
  };
}
