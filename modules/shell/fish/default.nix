{ pkgs, ... }: {
  programs.fish = {
    enable = true;
  };

  programs.foot = {
    enable = true;
    enableFishIntegration = true;
  };

  environment.systemPackages = with pkgs.fishPlugins; [
    done
    grc
    autopair
    puffer
    # fish-you-should-use
    async-prompt
  ] ++ [
    pkgs.grc
  ];
}
