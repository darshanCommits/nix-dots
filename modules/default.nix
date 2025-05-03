{...}: {
  imports = [
    ./hardware
    ./services
    ./fonts
    ./gaming
    ./keyd
    ./kvm
    ./waydroid
    ./coding
    ./cli
    ./dewm
    ./nh
    ./shell
    ./nix-settings
    ./users
    ./networking
  ];

  fakefastboot.enable = true;

  programs.dconf.enable = true;

  xdg.mime.enable = true;

  home-manager.backupFileExtension = "hm-backup";

  services.printing.enable = false;
  services.tor.enable = false;
  security.sudo = {
    enable = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  security.rtkit.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
