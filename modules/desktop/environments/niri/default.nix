{...}: {
  imports = [
    ./../common/brightness.nix
    ./../common/hyprlock
    ./../common/hypridle
    ./../common/sddm
  ];

  programs.niri = {
    enable = true;
  };
}
