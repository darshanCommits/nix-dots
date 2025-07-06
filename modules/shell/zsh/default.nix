{pkgs, ...}: {
  programs = {
    zsh.enable = false;
  };

  environment.systemPackages = with pkgs; [
    zsh-completions
  ];
}
