{
  lib,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["corefonts"];

  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    jetbrains-mono
  ];
}
