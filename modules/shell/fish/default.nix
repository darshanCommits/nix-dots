{ pkgs, ... }: {
  environment.systemPackages = with pkgs.fishPlugins; [
    done
    grc
    autopair
    puffer
    tide
    # fish-you-should-use
    async-prompt
  ] ++ [
    pkgs.grc
  ];

  programs.fish = {
    enable = true;
  };
}
