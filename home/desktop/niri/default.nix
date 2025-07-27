{self, ...}: let
  servicesPath = "${self}/home/desktop/services";
  services = map (service: "${servicesPath}/${service}") [
    "hyprlock"
    #mako"
    "swayidle"
    "waybar"
    "walker"
    "swaybg"
    "swaync"
    "xwayland-satellite"
    "poweralertd"
  ];
in {
  imports = services;

  services.swayosd = {
    enable = true;
  };
}
