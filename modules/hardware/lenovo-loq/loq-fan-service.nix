{pkgs, ...}: let
  loqFanCtl = pkgs.stdenv.mkDerivation {
    name = "loq-fan-control";
    src = ./service.sh;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      install -m755 $src $out/bin/loq-fan-control
    '';
  };
in {
  systemd.services.loq-fan-control = {
    description = "Lenovo LOQ Fan Control";
    after = ["multi-user.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${loqFanCtl}/bin/loq-fan-control";
      User = "root";
    };
  };

  systemd.timers.loq-fan-control = {
    description = "Run Lenovo LOQ Fan Control every 5s";
    wants = ["loq-fan-control.service"];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "5s";
    };
  };
}
