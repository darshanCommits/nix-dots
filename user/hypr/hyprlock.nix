{
  config,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        monitor = "";
        path = "/home/greeed/Pictures/Wallpapers/goatv3.jpg";
        color = "rgba(13, 17, 23, 0.7)";
        blur_passes = 1;
        blur_size = 2;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 1;
        outer_color = "rgb(151515)";
        inner_color = "rgba(13, 17, 23, 0.7)";
        font_color = "rgb(255,255,255)";
        fade_on_empty = false;
        placeholder_text = "";
        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = {
        monitor = "";
        text = "<b><i>In Tyler We Trusted.</i></b>";
        color = "rgba(200, 200, 200, 1.0)";
        font_size = 25;
        font_family = "JetBrains Mono";
        position = "0, 80";
        halign = "center";
        valign = "center";
      };
    };
  };
}
