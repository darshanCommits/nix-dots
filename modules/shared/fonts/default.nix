{ lib
, pkgs
, ...
}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "corefonts" ];

  fonts = {
    fontconfig.useEmbeddedBitmaps = true;
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      corefonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-sans
    ];
  };
}
