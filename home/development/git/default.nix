{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    lazygit
    gh
  ];

  programs.git = {
    enable = true;
    delta.enable = true;
    userName = config.ghUserName;
    userEmail = config.email;
    aliases = {
      st = "status - sb";
      last = "log -1 HEAD";
      ll = "log --oneline --graph --decorate --pretty=format:'%C(auto)%h%d %<(72,trunc)%s %C(green)(%ar) %C(yellow)%an%C(reset)'";
    };

    extraConfig = {
      core.editor = "hx";
      color.ui = "true";
      blame.date = "relative";
      init.defaultBranch = "master";
      pull.rebase = true;
      fetch.prune = true;
      log.abbrevCommit = true;
      push.autoSetupRemote = true;
    };
  };
}
