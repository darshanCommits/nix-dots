{config, ...}: {
  imports = [
    ./loq-fan-service.nix
  ];

  boot = {
    kernelModules = ["thinkpad_acpi"];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';
  };

  security.sudo.extraRules = [
    {
      users = [config.username];
      commands = [
        {
          command = "/run/current-system/sw/bin/tee /proc/acpi/ibm/fan";
          options = [ "SETENV" "NOPASSWD" ];        }
      ];
    }
  ];
}
