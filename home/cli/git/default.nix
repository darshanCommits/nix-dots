{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
    gh
  ];

  # programs.git = {
  #   enable = true;
  #   delta.enable = true;
  #   userName = config.ghUserName;
  #   userEmail = config.email;
  #   aliases = {
  #     st = "status -sb";
  #     last = "log -1 HEAD --stat";
  #     ll = "log --graph --oneline --decorate --pretty=format:'%C(auto)%h%d %<(72,trunc)%s %n%C(green)(%ar) %C(yellow)%an%C(reset)'";
  #   };

  #   extraConfig = {
  #     credential = {
  #       "https://github.com" = {
  #         helper = "!gh auth git-credential";
  #       };
  #       "https://gist.github.com" = {
  #         helper = "!gh auth git-credential";
  #       };
  #     };
  #     core.editor = "hx";
  #     color.ui = "true";
  #     blame.date = "relative";
  #     init.defaultBranch = "master";
  #     pull.rebase = true;
  #     fetch.prune = true;
  #     log.abbrevCommit = true;
  #     push.autoSetupRemote = true;
  #   };
  # };
}
