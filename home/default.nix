{ ... }:
let
  username = "greeed";
in
{
  programs.home-manager.enable = true;

  imports = [
    ./stylix
    ./mpv
    ./virtualization
  ];

  # REFER: @/modules/dewm/wl-clipboard
  services.cliphist = {
    enable = true;
  };

  home = {
    stateVersion = "25.05"; # Adapt this to the current Home Manager version
    username = username;
    homeDirectory = "/home/${username}";
    enableNixpkgsReleaseCheck = true;
  };


}
