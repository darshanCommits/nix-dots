{ inputs, pkgs, ... }: {
  imports = [
    ./sys-admin.nix
    ./media.nix
  ];
  programs.git.enable = true;

  programs.yazi = {
    enable = true;
  };

  programs.foot = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Terminal file management and navigation
    eza # ls replacement
    dua # disk usage analyzer
    zoxide # cd replacement with fuzzy finding

    # System monitoring and information
    bottom # top/htop replacement
    nitch # fetcher

    # Text processing and viewing
    glow # markdown viewer
    tealdeer # tldr implementation
    tokei # code statistics

    # Development tools that are primarily CLI-focused
    smartcat # ai cli
    comma # nix-shell replacement for quick commands
  ];
}
