{ pkgs, ... }: {
  imports = [
    ./ydotool.nix
  ];

  # REFER: @/home/default.nix
  # services.cliphist = {
  #   enable = true;
  # };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
