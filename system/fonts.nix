{
  lib,
  pkgs,
  inputs,
  ...
}: let
  jetbrains = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
in {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["corefonts"];

  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    jetbrains
    jetbrains-mono
  ];

  stylix.fonts = {
    sizes = {
      terminal = 14;
      desktop = 12;
      popups = 12;
      applications = 14;
    };

    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.ubuntu-sans;
      name = "Ubuntu Sans";
    };

    monospace = {
      package = jetbrains;
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
}
