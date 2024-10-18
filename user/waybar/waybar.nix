let 
  style = ./style.css;
  config = ./config.jsonc;
in {
  programs.waybar = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile config);
    style = builtins.readFile style;
  };
}
