{pkgs, ...}: {
  imports = [
    ./../common/hyprlock
    ./../common/mako
    ./../common/swayidle
    ./../common/waybar
    ./../common/swaybg
  ];

  home.packages = with pkgs; [
    xwayland-satellite
    walker
  ];
}
