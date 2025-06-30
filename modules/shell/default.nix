{ pkgs, ... }:
{
  imports = [
    ./fish
    ./zsh

    ./prompt

    ./aliases.nix
    ./envVars.nix
  ];

  environment.shells = with pkgs; [ fish ];
  users.defaultUserShell = pkgs.fish;


  environment.systemPackages = with pkgs; [
    fzf
    nushell # just in case i want to manipulate csv
  ];
}
