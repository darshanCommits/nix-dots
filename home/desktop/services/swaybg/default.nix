{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.swaybg
  ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      Restart = "on-failure";
      ExecStart = "${lib.getExe pkgs.swaybg} -i ${config.homeDir}/dotfiles/assets/images/goatv3.jpg";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
