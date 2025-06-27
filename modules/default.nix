{ ... }: {
  imports = [
    ./desktop
    ./cli
    ./core
    ./development
    ./services
    ./gaming
    ./shell
  ];

  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    loader.timeout = 2;
  };

  programs.dconf.enable = true;
  xdg.mime.enable = true;

  home-manager.backupFileExtension = "hm-backup";

  services.printing.enable = true;
  services.tor.enable = false;

  security.sudo.enable = true;
  security.rtkit.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
