{...}: {
  # imports = [
  #   ./../../services/brightness.nix
  #   ./../../services/hyprlock
  #   ./../../services/hypridle
  #   ./../../services/sddm
  # ];

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
