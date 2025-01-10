# for later
# hyprland scratchpads https://www.youtube.com/watch?v=CwGlm-rpok4&list=PL_WcXIXdDWWohRNPGXO6H9Ds3jM_0fT9P&index=2&t=349s
{
  pkgs,
  inputs,
  HOME,
  chaotic,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./system/power_management/thermals.nix
    ./system/power_management/auto-cpufreq.nix

    ./system/hardware/nvidia.nix
    ./system/hardware/opengl.nix

    ./system/keyd/keyd.nix

    ./system/de.nix
    ./system/gaming.nix

    ./system/sh.nix
    ./system/cli.nix
    ./system/fonts.nix
    ./system/gui.nix
    ./system/utilpkgs.nix
    ./system/coding.nix
    ./system/stylix.nix

    ./system/services/battery/low-battery.nix

    # ./home.nix
  ];

  nixpkgs.config.allowUnfree = true;

  programs.dconf.enable = true;
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    settings = {
      trusted-users = ["root" "@wheel" "greeed"];
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
    };
  };

  # services.scx.enable = true; # by default uses scx_rustland scheduler
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = ["preempt=full"];

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.shells = with pkgs; [zsh bash nushell];

  systemd = {
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
    SUBSYSTEM=="power_supply", ACTION=="change", \
    ENV{SYSTEMD_USER_WANTS}+="low-battery-check.service", \
    TAG+="systemd"
  '';

  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  services.tor.enable = true;

  security.rtkit.enable = true;
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${pkgs.brightnessctl}/bin/brightnessctl";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["users"];
      }
    ];
  };

  networking.hostName = "greeed-nix"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    # "en_IN.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  hardware.pulseaudio.enable = false;
  hardware.xone.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;

    # extraConfig = {
    #   pipewire."92-low-latency" = {
    #     "context.properties" = {
    #       "default.clock.rate" = 48000;
    #       "default.clock.quantum" = 64;
    #       "default.clock.min-quantum" = 64;
    #       "default.clock.max-quantum" = 64;
    #     };
    #   };
    #   pipewire-pulse."92-low-latency" = {
    #     context.modules = [
    #       {
    #         name = "libpipewire-module-protocol-pulse";
    #         args = {
    #           pulse.min.req = "64/48000";
    #           pulse.default.req = "64/48000";
    #           pulse.max.req = "64/48000";
    #           pulse.min.quantum = "64/48000";
    #           pulse.max.quantum = "64/48000";
    #         };
    #       }
    #     ];
    #     stream.properties = {
    #       node.latency = "64/48000";
    #       resample.quality = 1;
    #     };
    #   };
    # };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.bash;
    users.greeed = {
      isNormalUser = true;
      description = "Darshan Kumawat";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
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
  services.postgresql.enable = false;
  environment.systemPackages = with pkgs; [
    brightnessctl
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

  xdg.mime = {
    enable = true;
    defaultApplications = {
      # Browser-related MIME types
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];
      "x-scheme-handler/mailto" = ["brave-browser.desktop"];
      "text/html" = ["brave-browser.desktop"];

      # Image files to open with feh
      "image/png" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "image/gif" = ["feh.desktop"];
      "image/bmp" = ["feh.desktop"];
      "image/tiff" = ["feh.desktop"];
      "image/svg+xml" = ["feh.desktop"];

      # Video and audio files to open with mpv
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "audio/mpeg" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];
      "audio/wav" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];

      # Text files to open with Helix
      "text/plain" = ["Helix.desktop"];
      "text/xml" = ["Helix.desktop"];
      "application/json" = ["Helix.desktop"];
      "text/x-shellscript" = ["Helix.desktop"];
      "application/x-sh" = ["Helix.desktop"];
      "text/css" = ["Helix.desktop"];
      "application/x-yaml" = ["Helix.desktop"];
      "application/x-tar" = ["Helix.desktop"];

      # PDF files to open with Zathura
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];

      # File manager for directories
      "inode/directory" = ["thunar.desktop"];

      # Terminal: foot for terminal applications
      "x-scheme-handler/terminal" = ["foot.desktop"];

      # Telegram desktop application handlers
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
    };
  };

  home-manager.backupFileExtension = "backup";
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
  system.stateVersion = "24.05"; # Did you read the comment?
}
