{...}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false; # i dont use bt all that much
  };

  services.blueman.enable = true; # it will be set to false if hyprpanel is enabled
}
