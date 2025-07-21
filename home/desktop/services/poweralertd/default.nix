{pkgs, ...}: {
  # you will need to enable nixos upower module aswell
  home.packages = [
    pkgs.poweralertd
  ];
  systemd.user.services.poweralertd = {
    Unit = {
      Description = "UPower-powered power alerter";
      Documentation = "man:poweralertd(1)";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Install.WantedBy = ["graphical-session.target"];

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.poweralertd}/bin/poweralertd";
      Restart = "always";
    };
  };
}
