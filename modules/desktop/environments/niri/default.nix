{...}: {
  imports = [
    ./../common/brightness.nix
    ./../common/hyprlock
    ./../common/ly
  ];

  programs.niri = {
    enable = true;
  };
}
