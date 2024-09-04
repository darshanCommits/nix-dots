{
  config,
  pkgs,
  ...
}: {
  programs.tofi = {
    enable = true;
    settings = {
      font = "Sans";
      font-size = 16;
      num-results = 10;

      terminal = "footclient";
      outline-width = "0";
      border-width = "2";
      border-color = "FA5654";
      padding-left = "1%";
      padding-top = "3%";
      padding-right = "2%";
      padding-bottom = "0%";

      placeholder-text = "Search";
      prompt-text = ''""'';
      prompt-padding = 20;

      background-color = "0D1117";
      text-color = "DEDEDE";
      selection-color = "FA5654";
      result-spacing = 10;

      width = "45%";
      height = "50%";

      hide-cursor = true;
      text-cursor = true;
    };
  };
}
