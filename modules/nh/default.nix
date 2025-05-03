{HOME, ...}: {
  programs.nh = {
    enable = true;
    clean.enable = false;
    # clean.extraArgs = "--keep-since 4d --keep 5";
    flake = "${HOME}/dotfiles";
  };
}
