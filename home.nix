{
  pkgs,
  lib,
  inputs,
  # HOME,
  ...
}: {
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # Adapt this to the current Home Manager version
  home.username = "greeed";
  home.homeDirectory = "/home/greeed";
  home.enableNixpkgsReleaseCheck = false;

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  stylix = {
    enable = true;
    autoEnable = true;
    image = ./assets/wallpapers/goatv3.jpg;

    polarity = "dark";
    base16Scheme = {
      base00 = "0D1117";
      base01 = "3a3c4e";
      base02 = "4d4f68";
      base03 = "626483";
      base04 = "62d6e8";
      base05 = "e9e9f4";
      base06 = "f1f2f8";
      base07 = "f7f7fb";
      base08 = "ea51b2";
      base09 = "b45bcf";
      base0A = "00f769";
      base0B = "ebff87";
      base0C = "a1efe4";
      base0D = "62d6e8";
      base0E = "b45bcf";
      base0F = "00f769";
    };

    cursor = {
      package = pkgs.dracula-theme;
      name = "Dracula-cursors";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.dracula-icon-theme;
      dark = "Dracula";
      light = "Dracula";
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        name = "Ubuntu Sans";
        package = pkgs.ubuntu-sans;
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrains Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  gtk = lib.mkForce {
    enable = true;

    # font = {
    #   name = "Ubuntu Sans";
    #   package = pkgs.ubuntu-sans;
    #   size = 13;
    # };

    # iconTheme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-icon-theme;
    # };

    # cursorTheme = {
    #   name = "Dracula-cursors";
    #   package = pkgs.dracula-theme;
    #   size = 24;
    # };

    # theme = {
    #   name = "Dracula";
    #   package = pkgs.dracula-theme;
    # };
    # gtk2.extraConfig = ''
    #   gtk-button-images=1
    #   gtk-cursor-theme-name="Dracula-cursors"
    #   gtk-cursor-theme-size=24
    #   gtk-icon-theme-name="Dracula"
    #   gtk-theme-name="Dracula"
    #   gtk-enable-animations=1
    #   gtk-menu-images=1
    #   gtk-primary-button-warps-slider=1
    #   gtk-sound-theme-name="ocean"
    #   gtk-toolbar-style=3'';
  };

  qt = {
    enable = true;
    # style = {
    #   name = "Dracula";
    #   package = pkgs.dracula-qt5-theme;
    # };
  };

  # add mpv config here, its too cumbersome to maintain it in .config
  programs.mpv = {
    enable = true;
    scripts = [
      pkgs.mpvScripts.mpris
      pkgs.mpvScripts.uosc
      pkgs.mpvScripts.thumbfast
      pkgs.mpvScripts.autocrop
      pkgs.mpvScripts.autosubsync-mpv
      pkgs.mpvScripts.sponsorblock
    ];
    config = {
      osc = false;
      osd-bar = false;
      # profile = "gpu-hq";
      # hwdec = "vaapi";
      # gpu-api = "vulkan";
      # gpu-context = "waylandvk";
      # vaapi-device = "/dev/dri/renderD128";
      interpolation = true;
      video-sync = "display-resample";
      sub-auto = "fuzzy";
      save-position-on-quit = true;
      ignore-path-in-watch-later-config = true;
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      fullscreen = "yes";
      cache = "yes";
      cursor-autohide = 3500; #synchronized with hidetimeout
      sub-font = "Ubuntu";
      sub-border-size = 1;
      sub-color = "#FFFFFF";
      sub-shadow-color = "#000000";
      sub-shadow-offset = 2;
    };
    scriptOpts = {
      uosc = {
        timeline_size = 25;
        timeline_persistency = "paused,audio";
        top_bar = "never";
        refine = "text_width";
      };
      thumbfast = {
        spawn_first = true;
        network = true;
        hwdec = false;
      };
    };
  };

  services.kdeconnect.enable = true;
}
