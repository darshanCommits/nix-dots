{...}: {
  programs.hyprlock = {
    enable = true;
  };

  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
