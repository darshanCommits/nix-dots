{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./languages.nix
  ];
  programs.helix = {
    enable = true;
    package = inputs.helix-driver.packages.${pkgs.system}.helix;
    settings = builtins.fromTOML (builtins.readFile ./config.toml);
    themes = {
      glazor = ./glazor.theme.toml;
    };
  };
}
