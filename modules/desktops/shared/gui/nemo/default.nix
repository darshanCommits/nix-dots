{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nemo
    nemo-python
    nemo-fileroller
    nemo-emblems
  ];
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  programs.thunar = {
    enable = false;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
