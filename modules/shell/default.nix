{ pkgs, ... }:
{
  imports = [
    ./fish
    ./zsh

    ./prompt
    ./atuin

    ./aliases.nix
    ./envVars.nix
  ];

  environment.shells = with pkgs; [ fish zsh ];
  users.defaultUserShell = pkgs.fish;


  environment.systemPackages = with pkgs; [
    carapace
    fzf
    nushell # just in case i want to manipulate csv
  ];
}
