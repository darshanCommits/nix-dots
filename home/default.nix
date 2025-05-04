{...}: let
  username = "greeed";
in {
  programs.home-manager.enable = true;

  imports = [
    ./stylix
    ./kdeconnect
    ./mpv
    ./zen-browser
    ./dconf
  ];

  # REFER: @/modules/dewm/wl-clipboard
  services.cliphist = {
    enable = true;
  };

  home = {
    stateVersion = "24.11"; # Adapt this to the current Home Manager version
    username = username;
    homeDirectory = "/home/${username}";
    enableNixpkgsReleaseCheck = false;
  };
}
