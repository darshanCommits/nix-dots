{
  config,
  inputs,
  pkgs,
  ...
}: let
  path_devshells = "${config.home.homeDirectory}/.dotfiles/user/dev/devshells";
  icon_pkg = pkgs.dracula-icon-theme;
  icon_name = "Dracula";
in {
  imports = [
    ./user/zsh/sh.nix

    ./user/hypr/hyprland.nix
    # ./user/hypr/hyprlock.nix
    ./user/hypr/hypridle.nix

    # ./user/foot/foot.nix
    # ./user/mako/mako.nix
    ./user/stylix/stylix.nix
    ./user/waybar/waybar.nix
    ./user/git/git.nix
    ./user/mpv/mpv.nix
    ./user/tofi/tofi.nix
    ./user/zathura/zathura.nix

    ./user/desktop-entries/default.nix

    ./system/services/battery/low-battery.nix

    ./user/dev/rust.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # DO NOT TOUCH
  home.username = "greeed";
  home.homeDirectory = "/home/greeed";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    GSK_RENDERER = "gl"; # BUG IN NVIDIA LATEST DRIVER FOR GTK APPS
    DEVSHELLS = "${path_devshells}";
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "brave";
    TERMINAL = "footclient";
    VIDEO_PLAYER = "mpv";
    AUDIO_PLAYER = "mpv";

    NIXOS_OZONE_WL = 1;
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";

    HISTFILE = "${config.home.homeDirectory}/.zsh_history";
    # HISTFILE = "/home/greeed/.zsh_history"; # I started using atuin
  };

  programs.bun.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/mailto" = ["brave-browser.desktop"];
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
      "image/png" = ["feh.desktop"];
      "image/jpeg" = ["feh.desktop"];
      "application/x-ms-shortcut" = ["Helix.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];

      "inode/directory" = ["thunar.desktop"];
    };
  };

  home.packages = with pkgs; [
    webp-pixbuf-loader
    poppler
    ffmpegthumbnailer

    # User-specific utilities and tools
    gh

    # Media and productivity
    # mpv

    # Hypr ecosystem (user-specific components)
    pyprland

    #GAMES

    #GUI
    foot
    webcord-vencord
    spotify
    spicetify-cli
    gpu-screen-recorder
    mangohud
    montserrat


    sqlite
    # rustup
    openssl
    tetex
    # weka
    # rPackages.RWekajars

    # web
    biome
    jdt-language-server
    tree-sitter
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
    # platformTheme.name = "gtk";
    style.name = "kvantum";
  };

  # programs.home-manager.enable = true;

  programs.wezterm.enable = true;
}
