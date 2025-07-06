{pkgs, ...}: {
  imports = [
    ./nix-settings
    ./pipewire
    ./bluetooth
  ];

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batman
      prettybat
    ];

    settings = {
      style = "plain";
    };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    openssl
    # Basic file operations
    fd # find replacement
    ripgrep-all # grep replacement with additional format support

    # Basic utilities
    bc # calculator
    jq # JSON processor
    unzip # archive extraction
    unrar # rar extraction
    p7zip # 7zip support

    # System monitoring essentials
    killall # process management
    lsof # list open files
  ];
}
