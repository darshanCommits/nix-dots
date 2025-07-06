{...}: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            leftalt = "layer(alt)";
            capslock = "overload(control, esc)";
            insert = "S-insert"; # obvious ig?
          };
          otherlayer = {};
        };
        extraConfig = ''
          [alt]
          h = left
          j = down
          k = up
          l = right

          a = C-a
          v = S-insert
          c = C-insert
          q = C-delete
          d = delete

          [control:C]
          p = up
          n = down

          h = backspace
          j = enter
          f = C-right
          b = C-left
          a = home
          e = end
          w = C-backspace
        '';
      };
    };
  };
}
