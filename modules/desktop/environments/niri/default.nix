{...}: {
  imports = [
    ./../common/brightness.nix
    ./../common/hyprlock
    ./../common/sddm
  ];

  programs.niri = {
    enable = true;
  };
}
