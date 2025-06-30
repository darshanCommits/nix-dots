{ ... }: {
  imports = [
    ./git
    ./virtualization
    ./foot
    ./helix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      enter_accept = false;
      filter_mode_shell_up_key_binding = "directory";
    };
  };
}
