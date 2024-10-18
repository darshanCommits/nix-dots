# for later
# hyprland scratchpads https://www.youtube.com/watch?v=CwGlm-rpok4&list=PL_WcXIXdDWWohRNPGXO6H9Ds3jM_0fT9P&index=2&t=349s
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    # ./system/power_management/undervolt.nix # device specific
    ./system/power_management/thermals.nix
    ./system/power_management/auto-cpufreq.nix
    # ./system/power_management/tlp.nix

    ./system/hardware/nvidia.nix
    ./system/hardware/opengl.nix

    ./system/keyd/keyd.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

  nix = {
    settings = {
      trusted-users = ["root" "@wheel" "greeed"];
      experimental-features = ["nix-command" "flakes"];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  environment.shells = with pkgs; [zsh bash];
  programs.zsh.enable = true;

  # xdg.portal.enable = true;
  # xdg.portal.config.common.default = "*";

  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;
  # services.jupyter.enable = true;


  # services.xserver.enable = true;

  security.rtkit.enable = true;
  security.polkit.enable = true;

  networking.hostName = "greeed-nix"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # Configure keymap in X11
  # services.xserver = {
  #   xkb.layout = "us";
  #   xkb.variant = "";
  # };

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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.greeed = {
      isNormalUser = true;
      description = "Darshan Kumawat";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "audio"
        "input"
      ];
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/greeed/.dotfiles";
  };

  programs.hyprland = {
    enable = true;
    # xwayland.enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Thunar config
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  # GAMING

  programs.gamemode.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.java.enable = true; 

  # services.mongodb.enable = true;
  services.postgresql.enable = true;
  # services.mysql.enable = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    pciutils
    wineWowPackages.stable
    libnotify
    brightnessctl
    wl-clipboard
    unzip
    xwaylandvideobridge
    killall
    wget
    stress-ng
    aria2
    gparted
    mariadb
    git
    delta
    nh
    vim
    p7zip
    wtype
    dracula-theme
    dracula-icon-theme
    hyprlock
    hypridle
    libsForQt5.qtstyleplugin-kvantum
    polkit-kde-agent
    android-tools
    onlyoffice-bin
    corefonts
  ];

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
