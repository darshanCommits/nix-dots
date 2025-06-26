{ inputs
, HOME
, pkgs
, ...
}: {
  programs.git.enable = true;

  programs.yazi = {
    enable = true;
    flavors = {
      dracula = ''${HOME}/assets/dracula.yazi.toml'';
    };
    settings = {
      theme = builtins.fromTOML ''
        [flavor]
        use = "dracula"
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    vim
    bc
    bottom
    comma
    dua
    eza
    fd
    glow
    jq
    nitch
    ripgrep-all
    smartcat
    tealdeer
    tokei
    zoxide
    inputs.helix-driver.packages.${pkgs.system}.helix
  ];
}
