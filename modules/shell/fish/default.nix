{ pkgs, ... }: {
  programs.fish = {
    enable = true;
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
