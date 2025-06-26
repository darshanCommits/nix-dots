{ ... }:
{
  imports = [
    # ./loq-fan-service.nix
  ];

  boot = {
    kernelModules = [ "thinkpad_acpi" ];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';
  };

  # services.loqFanControl = {
  #   enable = true;

  #   interval = 5;

  #   temperatureThresholds = [
  #     { temp = 30; level = 0; } # Below 30°C: level 0
  #     { temp = 40; level = 1; } # Below 30°C: level 0
  #     { temp = 45; level = 2; } # Below 40°C: level 2
  #     { temp = 50; level = 3; } # Below 50°C: level 4
  #     { temp = 55; level = 4; } # Below 50°C: level 4
  #     { temp = 60; level = 5; } # Below 60°C: level 5 
  #     { temp = 65; level = 6; } # Below 65°C: level 6
  #     { temp = 999; level = 7; } # Above 70°C: level 7 (maximum)
  #   ];
  # };
}
