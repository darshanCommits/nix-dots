{inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; (
    let
      defaultPkgs = [
        unzip
        p7zip
        killall
        wget
        pciutils
        libnotify
        aria2
        vim
        jq
        bc
        tealdeer
        nitch
        bottom
      ];

      devEnvPkgs = [
        gh
        tokei
        smartcat
        lazygit
        glow
        act # i dont actually know how to use this
        inputs.helix-master.packages.${pkgs.system}.helix
      ];

      replacementPkgs = [
        bat
        bat-extras.batgrep
        bat-extras.batman
        bat-extras.batpipe
        bat-extras.prettybat
        dua
        zoxide
        ripgrep-all
        fd
        eza
      ];

      miscPkgs = [
        stress-ng
        tesseract
        imagemagick
        yazi
      ];

      nixosPkgs = [
        comma
      ];
    in
      defaultPkgs
      ++ devEnvPkgs
      ++ replacementPkgs
      ++ miscPkgs
      ++ nixosPkgs
  );
}
