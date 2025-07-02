{ pkgs
, inputs
, ...
}: {
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.x86_64-linux.default;

    config = {
      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        dictionary
        randr
        rink
        shell
        symbols
      ];

      width.fraction = 0.25;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile ./style.css;

    extraConfigFiles = {
      "uwsm_app.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
        )
      '';

      "shell.ron".text = ''
        Config(
          prefix: ">"
        )
      '';

      "randr.ron".text = ''
        Config(
          prefi: ":dp",
          max_entries: 5,
        )
      '';
    };
  };
}
