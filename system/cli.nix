{
  inputs,
  pkgs,
  ...
}: {
  programs.git.enable = true;
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Terminal Shells and Enhancements
    atuin
    unstable.carapace
    nushell
    starship
    # zsh-completions

    # File Management and Navigation
    unstable.bat
    bat-extras.batman
    bat-extras.batpipe
    dua
    eza
    fd
    ripgrep-all
    tokei
    unstable.yazi
    zoxide

    # Version Control and Development
    act
    delta
    gh
    git
    lazygit

    # System Monitoring and Utilities
    bottom
    exiftool
    brightnessctl
    killall
    lsof
    nitch
    pciutils
    usbutils
    libva-utils
    glxinfo

    stress-ng

    # Text and Document Processing
    glow
    jq
    smartcat
    tesseract

    vim
    inputs.helix-forked.packages.${pkgs.system}.helix

    # Network and Download Tools
    aria2
    dig
    wget

    # Android Development
    android-tools

    # Archive and Compression
    p7zip
    unzip
    unrar

    # Media and Image Processing
    imagemagick
    ani-cli

    # Other Utilities
    bc
    comma
    corefonts
    libnotify
    nh
    tealdeer
    wtype
  ];
}
