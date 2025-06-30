{ ... }: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "󰘧(bold green)";
        error_symbol = "󰘧(bold red)";
        vimcmd_symbol = "[V](bold green)";
      };
    };
  };
}
