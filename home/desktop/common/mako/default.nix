{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
  ];
  services.mako = {
    enable = true;
    settings = {
      background-color = "#000000";
      text-color = "#CDD6F4";
      font = "JetBrainsNerd Font 11";
      border-color = "#ff4835";
      padding = 13;
      icons = 1;
      max-icon-size = 64;
      margin = 10;
      border-size = 2;
      border-radius = 0;
      progress-color = "#ff4835";
      default-timeout = 5000;
      layer = "overlay";
      # width="300";
      height = 200;
    };
  };
}
