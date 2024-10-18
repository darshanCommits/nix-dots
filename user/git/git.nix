{
  ...
}: {
  programs.git = {
    enable = true;
    userEmail = "kumawatdarshan.1304@gmail.com"; # FIXME: set your git email
    userName = "darshanCommits"; #FIXME: set your git username
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
  };
}
