{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.grc
    grc
  ];

  programs.fish = {
    enable = true;
  };
}
