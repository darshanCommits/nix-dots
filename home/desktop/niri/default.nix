{ pkgs, ... }: {
  imports = [
    ./../common/hyprlock
    ./../common/swayidle
    ./../common/waybar
    ./../common/mako
  ];

  home.packages = with pkgs; [
    xwayland-satellite
  ];
}
