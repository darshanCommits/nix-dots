{ inputs, pkgs, ... }: {
  imports = [
    ./sys-admin.nix
    ./media.nix
    ./nh.nix
  ];
  programs.git.enable = true;

  programs.yazi = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Terminal file management and navigation
    eza # ls replacement
    dua # disk usage analyzer

    # System monitoring and information
    bottom # top/htop replacement
    nitch # fetcher

    # Text processing and viewing
    glow # markdown viewer
    tlrc # tldr implementation
    tokei # code statistics

    # Development tools that are primarily CLI-focused
    smartcat # ai cli
  ];
}
