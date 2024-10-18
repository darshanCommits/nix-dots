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
    ./user/zsh/sh.nix

    ./user/hypr/hyprland.nix
    ./user/hypr/hyprlock.nix
    ./user/hypr/hypridle.nix

    ./user/foot/foot.nix
    ./user/mako/mako.nix
    ./user/stylix/stylix.nix
    ./user/waybar/waybar.nix
    ./user/git/git.nix
    ./user/mpv/mpv.nix
    ./user/tofi/tofi.nix
    ./user/zathura/zathura.nix
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

    NIXOS_OZONE_WL = 1;
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";

    HISTFILE = "/home/greeed/.zsh_history";
  };

  programs.bun.enable = true;

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
    comma

    inputs.umu.packages.${pkgs.system}.umu 

    waybar
    grimblast
    swaybg
    tesseract

    # Hypr ecosystem (user-specific components)
    pyprland
    hyprpicker
    hyprcursor


    #GAMES
    heroic
    lutris
    
    #GUI
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

    lazygit

    go
    nodejs
    typescript
    jupyter

    taplo
    hyprls
    alejandra # nix formatter
    nixd
    nil
    nodePackages.bash-language-server
    ccls
    cmake
    rustup
    gcc
    openssl
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
