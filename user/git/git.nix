{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userEmail = "104432537+darshanCommits@users.noreply.github.com"; # FIXME: set your git email
    userName = "darshanCommits"; #FIXME: set your git username
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
  };
}
