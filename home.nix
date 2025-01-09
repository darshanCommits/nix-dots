{
  pkgs,
  inputs,
  # HOME,
  ...
}: {
  imports = [
    ./system/stylix.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # Adapt this to the current Home Manager version
  home.username = "greeed";
  home.homeDirectory = "/home/greeed";
  home.enableNixpkgsReleaseCheck = false;

  services.easyeffects.enable = true;
  wayland.windowManager.hyprland.plugins = [
    inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
  ];
}
