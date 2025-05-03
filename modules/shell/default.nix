{pkgs, ...}: {
  imports = [
    ./atuin
  ];
  # installed nushell using hm
  programs.starship.enable = true;
  environment.shells = with pkgs; [zsh bash];

  environment.systemPackages = with pkgs; [
    carapace
    atuin
    nushell
  ];
}
