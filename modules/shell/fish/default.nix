{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit =
      #fish
      ''
        fish_config theme choose Dracula
        set -g fish_greeting
        set -g async_prompt_functions _pure_prompt_git
        # atuin init fish | source
        # zoxide init --cmd j fish | source

        # set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'
        # carapace _carapace | source
      '';
  };

  environment.systemPackages = with pkgs.fishPlugins;
    [
      done
      grc
      autopair
      puffer
      async-prompt
    ]
    ++ [
      pkgs.grc
    ];
}
