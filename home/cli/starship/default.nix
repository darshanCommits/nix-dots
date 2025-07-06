{...}: {
  programs.starship = {
    enable = false;

    settings = {
      add_newline = true;
      format = "$all";
      character = {
        success_symbol = "󰘧(bold green)";
        error_symbol = "󰘧(bold red)";
        vimcmd_symbol = "[V](bold green)";
      };
    };
  };
}
