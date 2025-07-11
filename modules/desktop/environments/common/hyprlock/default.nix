{...}: {
  programs.hyprlock = {
    # enable = false; enabled from HM
  };

  security.pam.services.hyprlock.enableGnomeKeyring = true;
}
