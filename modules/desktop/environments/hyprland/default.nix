{ ... }: {
  imports = [
    ./hyprpanel.nix
    ./../common/brightness.nix
    ./../common/hyprlock
    ./../common/hypridle
    ./../common/sddm
  ];

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
