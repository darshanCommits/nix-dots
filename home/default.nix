{ config, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./stylix
    ./cli
    ./desktop
    ./development
    ./media
    ./../lib
  ];

  # REFER: @/modules/dewm/wl-clipboard
  services.cliphist = {
    enable = true;
  };

  home = {
    stateVersion = "25.05"; # Adapt this to the current Home Manager version
    username = config.username;
    homeDirectory = "/home/${config.username}";
    enableNixpkgsReleaseCheck = true;
  };
}
