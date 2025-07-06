{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [
    pkgs.starship
  ];
  programs.starship = {
    enable = true;
    # add_newline = true;

    # format = lib.concatStrings [
    #   "$username"
    #   "$hostname"
    #   "$directory"
    #   "$git_branch"
    #   "$git_status"
    #   "$nix_shell"
    #   "$cmd_duration"
    #   "$line_break"
    #   "$character"
    # ];
  };
}
