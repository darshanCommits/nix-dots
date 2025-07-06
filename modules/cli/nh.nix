{config, ...}: {
  programs.nh = {
    enable = true;
    clean.extraArgs = "--keep 4";
    flake = "${config.homeDir}/dotfiles";
  };
}
