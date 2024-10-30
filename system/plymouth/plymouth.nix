{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    plymouth
  ];

  boot = {
    plymouth = {
      enable = true;
      theme = lib.mkForce "cross_hud";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = ["cross_hud"];
        })
      ];
    };

    consoleLogLevel = 0;
    # initrd.verbose = false;
    # loader.timeout = 0;

    kernelParams = [
      "quiet"
      # "splash"
      # "boot.shell_on_fail"
      "loglevel=3"
      # "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };
}
