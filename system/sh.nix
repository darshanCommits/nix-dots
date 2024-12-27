{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.git.enable = true;
  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableGlobalCompInit = true;

    syntaxHighlighting.enable = true;
    zsh-autoenv.enable = true;

    autosuggestions.enable = true;
    autosuggestions.async = true;
  };

  services.atuin.enable = true;

  environment.packages = with pkgs; [
    # shell
    starship
    zsh-completions

    nushell
  ];
}
