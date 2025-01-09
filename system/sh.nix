{
  config,
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
    # shell
    starship
    zsh-completions
    atuin
    nushell
    carapace
  ];
}
