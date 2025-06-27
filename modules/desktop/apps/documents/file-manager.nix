{ pkgs, ... }: {
  programs.xfconf.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs; [
    nemo
    nemo-python
    nemo-fileroller
    nemo-emblems
  ];

}
