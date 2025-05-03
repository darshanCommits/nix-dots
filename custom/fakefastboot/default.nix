{
  config,
  lib,
  ...
}: let
  cfg = config.fakefastboot;
in {
  options.fakefastboot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Changes boot params to reduce verbosity and make timeout to 2s.";
    };
    timeout = lib.mkOption {
      type = lib.types.int;
      default = 2;
      description = "Timeout before it auto boots into the default entry.";
    };
  };
  config = lib.mkIf cfg.enable {
    fakefastboot = {
      timeout = lib.mkDefault 2; # Automatically sets the default when enabled
    };
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
      loader.timeout = cfg.timeout;
    };
  };
}
