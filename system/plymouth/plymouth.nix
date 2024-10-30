{pkgs, ...}: {
  boot.plymouth = {
    enable = true;
    theme = "";
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = ["cross_hud"];
      })
    ];
  };
}
