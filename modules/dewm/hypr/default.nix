{ ...
}: {
  imports = [
    ./hyprpanel.nix
    ./brightness.nix
  ];

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.hyprlock = {
    enable = true;
  };

  security.pam.services.hyprlock.enableGnomeKeyring = true;

  services.hypridle = {
    enable = true;
  };
}
