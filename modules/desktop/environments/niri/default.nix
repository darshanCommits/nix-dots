{
  self,
  pkgs,
  ...
}: let
  servicesPath = "${self.outPath}/modules/desktop/services";
  services = map (service: "${servicesPath}/${service}") [
    "brightness.nix"
    "hyprlock"
  ];
in {
  imports = services;

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
    };
  };
  programs.niri = {
    enable = true;
  };
}
