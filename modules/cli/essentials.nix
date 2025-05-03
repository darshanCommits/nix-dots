{
  inputs,
  pkgs,
  ...
}: {
  programs.starship.enable = true;
  programs.git.enable = true;

  programs.yazi = {
    enable = true;
    # TODO: use the nixpkgs version once the helix fix lands in stable nixpkgs
    package = inputs.yazi.packages.${pkgs.system}.default;
  };

  environment.systemPackages = with pkgs; [
    starship
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
