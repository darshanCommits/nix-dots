# for later
# hyprland scratchpads https://www.youtube.com/watch?v=CwGlm-rpok4&list=PL_WcXIXdDWWohRNPGXO6H9Ds3jM_0fT9P&index=2&t=349s
{
  pkgs,
  inputs,
  HOME,
  ...
}:
# let
# browser-desktop = "zen.desktop";
# image-desktop = "feh.desktop";
# video-desktop = "mpv.desktop";
# editor-desktop = "Helix.desktop";
# in
{
  imports = [
    ./hardware-configuration.nix

    ./system/power_management/thermals.nix
    ./system/power_management/auto-cpufreq.nix
    ./system/power_management/undervolt.nix

    ./system/hardware/nvidia.nix
    ./system/hardware/opengl.nix

    ./system/keyd/keyd.nix

    ./system/de.nix
    ./system/gaming.nix
    ./system/flatpak.nix
    ./system/waydroid.nix

    ./system/cli.nix
    ./system/llm.nix
    ./system/fonts.nix
    ./system/gui.nix
    ./system/virt-manager.nix

    ./system/coding.nix
    ./system/postgresql.nix
    ./system/docker.nix
    ./system/mongodb.nix

    ./system/services/battery/low-battery.nix

    # ./home.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs.dconf.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  environment.shells = with pkgs; [zsh bash nushell];
  systemd = {
    extraConfig = "DefaultLimitNOFILE=2048";
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Monitor power supply changes (AC adapter and battery events)
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  services.openssh.enable = true;
  services.printing.enable = false;
  services.tor.enable = true;

  security.sudo = {
    enable = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.dnsmasq.enable = false;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    # "en_IN.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  hardware.xone.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = false;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 2048;
        "default.clock.max-quantum" = 2048;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.nushell;
    users.greeed = {
      isNormalUser = true;
      description = "Darshan Kumawat";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "input"
        "gamemode"
      ];
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "${HOME}/.dotfiles";
  };

  programs.xfconf.enable = true;

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  # GAMING
  environment.systemPackages = with pkgs; [
    qalculate-qt

    git
    delta
    webp-pixbuf-loader
    poppler
    ffmpegthumbnailer

    dracula-theme
    dracula-icon-theme
    android-tools
    onlyoffice-bin
  ];

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      trusted-users = ["root" "@wheel" "greeed"];
      experimental-features = ["nix-command" "flakes"];
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://anyrun.cachix.org"
        "https://nix-community.cachix.org"

        "https://hyprland.cachix.org"
        "https://helix.cachix.org"

        "https://chaotic-nyx.cachix.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="

        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };
  };

  xdg.mime = {
    enable = true;
    # defaultApplications = {
    #   "text/html" = [browser-desktop];
    #   "application/xhtml+xml" = [browser-desktop];
    #   "x-scheme-handler/http" = [browser-desktop];
    #   "x-scheme-handler/https" = [browser-desktop];
    #   "x-scheme-handler/about" = [browser-desktop];
    #   "x-scheme-handler/unknown" = [browser-desktop];

    #   # Browser-related MIME types
    #   # "x-scheme-handler/http" = ["brave-browser.desktop"];
    #   # "x-scheme-handler/https" = ["brave-browser.desktop"];
    #   # "x-scheme-handler/mailto" = ["brave-browser.desktop"];
    #   # "text/html" = ["brave-browser.desktop"];

    #   # Image files to open with feh
    #   "image/png" = [image-desktop];
    #   "image/jpeg" = [image-desktop];
    #   "image/gif" = [image-desktop];
    #   "image/bmp" = [image-desktop];
    #   "image/tiff" = [image-desktop];
    #   "image/svg+xml" = [image-desktop];

    #   # Video and audio files to open with mpv
    #   "video/mp4" = [video-desktop];
    #   "video/x-matroska" = [video-desktop];
    #   "video/x-msvideo" = [video-desktop];
    #   "video/webm" = [video-desktop];
    #   "audio/mpeg" = [video-desktop];
    #   "audio/ogg" = [video-desktop];
    #   "audio/wav" = [video-desktop];
    #   "audio/flac" = [video-desktop];

    #   # Text files to open with Helix
    #   "text/plain" = [editor-desktop];
    #   "text/xml" = [editor-desktop];
    #   "application/json" = [editor-desktop];
    #   "text/x-shellscript" = [editor-desktop];
    #   "application/x-sh" = [editor-desktop];
    #   "text/css" = [editor-desktop];
    #   "application/x-yaml" = [editor-desktop];

    #   # PDF files to open with Zathura
    #   "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];

    #   # File manager for directories
    #   "inode/directory" = ["thunar.desktop"];

    #   # Terminal: foot for terminal applications
    #   "x-scheme-handler/terminal" = ["foot.desktop"];

    #   # Telegram desktop application handlers
    #   "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
    #   "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
    # };
  };

  home-manager.backupFileExtension = "hm-backup";
  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
