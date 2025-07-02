{ ... }: {
  imports = [ ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = builtins.fromJSON (builtins.readFile ./config.jsonc);
    style = ./style.css;
  };
}
