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
    enableGlobalCompInit = true;

    syntaxHighlighting.enable = true;
    zsh-autoenv.enable = true;

    autosuggestions.enable = true;
    autosuggestions.async = true;
    shellInit = ''
      eval "$(zoxide init zsh)"
    '';


    shellAliases = {
      lsv = "live-server";
      cat = "prettybat";
      man = "batman";
      rg = "batgrep";
      j = "z";
      cd = "z";
      img = "wezterm imgcat";
      anime = "ani-cli";
      "..." = "cd ../..";
      pdf = "zathura";
      onlyoffice = "onlyoffice-desktopeditors --force-scale=1.25";
      onlyoffice-desktopeditors = "onlyoffice-desktopeditors --force-scale=1.25";

      ls = "eza -g --icons --header --group-directories-first";
      la = "eza -lag --icons --header --group-directories-first";
      lr = "eza -Tg -L 2 --icons --header --group-directories-first";
      lR = "eza -Tg --icons --header --group-directories-first";

      mkdir = "mkdir -pv";
      mount = "mount |column -t";

      # GIT
      ga = "git add .";
      gcm = "git commit -m";
      gca = "git commit --amend";
      push = "git push";
      gcl = "git clone";
    };
  };

  services.atuin.enable = true;

  environment.systemPackages = with pkgs; [
    # shell
    starship
    zsh-completions
    atuin
    nushell
  ];
}
