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
    carapace
    nushell
    starship
    zsh-completions

    # File Management and Navigation
    bat
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batpipe
    bat-extras.prettybat
    chezmoi
    dua
    eza
    fd
    ripgrep-all
    tokei
    yazi
    zoxide

    # Version Control and Development
    act
    delta
    gh
    git
    lazygit

    # System Monitoring and Utilities
    bottom
    brightnessctl
    killall
    lsof
    nitch
    pciutils
    stress-ng
    usbutils

    # Text and Document Processing
    glow
    jq
    smartcat
    tesseract
    vim
    inputs.helix-master.packages.${pkgs.system}.helix

    # Network and Download Tools
    aria2
    dig
    wget

    # Android Development
    android-tools

    # Archive and Compression
    p7zip
    unzip

    # Media and Image Processing
    imagemagick

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
