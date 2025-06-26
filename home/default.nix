{ lib, pkgs, ... }:
let
  username = "greeed";
in
{
  programs.home-manager.enable = true;

  imports = [
    ./stylix
    ./mpv
    # ./zen-browser
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
    activation.configure-tide = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time='12-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Many icons' --transient=Yes"
    '';
  };


}
