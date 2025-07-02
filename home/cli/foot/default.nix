{ ... }: {
  programs.foot = {
    enable = true;
    server.enable = true;

    settings = {
      main = {
        title = "Terminal";
        font = "JetBrainsMono Nerd Font:size=14";
        pad = "13x0";
        resize-delay-ms = 10;
        bold-text-in-bright = "no";
      };

      cursor.color = "1A1826 D9E0EE";

      colors = {
        background = "0D1117";
        foreground = "f8f8f2";

        regular0 = "21222c"; # black
        regular1 = "ff5555"; # red
        regular2 = "50fa7b"; # green
        regular3 = "f1fa8c"; # yellow
        regular4 = "bd93f9"; # blue
        regular5 = "ff79c6"; # magenta
        regular6 = "8be9fd"; # cyan
        regular7 = "f8f8f2"; # white

        bright0 = "6272a4"; # bright black
        bright1 = "ff6e6e"; # bright red
        bright2 = "69ff94"; # bright green
        bright3 = "ffffa5"; # bright yellow
        bright4 = "d6acff"; # bright blue
        bright5 = "ff92df"; # bright magenta
        bright6 = "a4ffff"; # bright cyan
        bright7 = "ffffff"; # bright white

        selection-foreground = "ffffff";
        selection-background = "44475a";
        urls = "8be9fd";
      };
    };
  };
}
