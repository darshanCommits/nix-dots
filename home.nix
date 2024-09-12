{
  inputs,
  config,
  pkgs,
  ...
}: let
  icon_pkg = pkgs.dracula-icon-theme;
  icon_name = "Dracula";
in {
  imports = [
    ./user/sh.nix
    ./user/tofi/tofi.nix

    ./user/hypr/hyprland.nix
    ./user/hypr/hyprlock.nix
    ./user/hypr/hypridle.nix

    ./user/stylix/stylix.nix
    # ./user/helix/helix.nix
    # ./user/helix/language-servers.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # DO NOT TOUCH
  home.username = "greeed";
  home.homeDirectory = "/home/greeed";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "brave";
    TERMINAL = "footclient";
    VIDEO_PLAYER = "mpv";
    AUDIO_PLAYER = "mpv";

    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = 1;
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";

    HISTFILE = "/home/greeed/.zsh_history";
  };

  home.packages = with pkgs; [
    webp-pixbuf-loader
    poppler
    ffmpegthumbnailer

    # User-specific utilities and tools
    gh
    cliphist
    starship

    # Media and productivity
    # mpv
    zathura
    comma

    waybar
    tofi
    mako
    grimblast
    swaybg
    tesseract

    # Hypr ecosystem (user-specific components)
    pyprland
    hyprpicker
    hyprcursor

    #GUI
    libreoffice-qt
    telegram-desktop
    brave
    foot
    stremio
    webcord-vencord
    spotify
    spicetify-cli

    gpu-screen-recorder
    mangohud
    protonup
    montserrat
    tokei
    imagemagick

    go
    nodejs
    typescript
    jupyter

    (python3.withPackages (ps:
      with ps; [
        numpy
        scipy
        matplotlib
        notebook
      ]))

    taplo
    hyprls
    alejandra # nix formatter
    nixd
    nil
    nodePackages.bash-language-server
    ccls
    cmake
    rustup
    jdk
    weka
    rPackages.RWekajars

    # web
    biome
    jdt-language-server
    typescript-language-server
    emmet-language-server
    vscode-langservers-extracted
  ];

  # syntax => "<filepath>".source = <flakepath>; if i wish to use as is
  # "<filepath>".text = ''<content>'' or if i wish to write it inside nix module
  home.file = {};

  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.helix = {
    enable = true;
    package = inputs.helix-master.packages.${pkgs.system}.default;
    # Add any other Helix-specific configurations here
  };

  programs.mpv = {
    enable = true;
    config = {
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
      gpu-context = "wayland";
      ytdl-format = "bestvideo+bestaudio";
    };
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.thumbfast
      mpvScripts.autosubsync-mpv # press n
    ];
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = icon_pkg;
      name = icon_name;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  programs.home-manager.enable = true;
}
