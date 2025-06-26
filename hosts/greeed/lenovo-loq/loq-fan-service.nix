{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.loqFanControl;

  pythonEnv = pkgs.python3;

  loqFanControlScript = pkgs.writeScriptBin "loq-fan-control" (
    pkgs.replaceVars {
      file = ./loq-fan-control.py.in;
      replacements = {
        stateDir = cfg.stateDir;
        interval = toString cfg.interval;
        temperatureThresholds = builtins.toJSON cfg.temperatureThresholds;
        overrideTimeout = toString cfg.overrideTimeout;
      };
    }
  );

  loqFanControlWrapped = pkgs.symlinkJoin {
    name = "loq-fan-control-env";
    paths = [ loqFanControlScript ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/loq-fan-control \
        --prefix PATH : ${lib.makeBinPath [ pythonEnv ]}
    '';
  };
in
{
  options.services.loqFanControl = {
    enable = mkEnableOption "Lenovo LOQ Fan Control Service";

    interval = mkOption {
      type = types.int;
      default = 5;
      description = "Interval in seconds to check temperature and adjust fan speed";
    };

    stateDir = mkOption {
      type = types.path;
      default = "/var/lib/loq-fan-control";
      description = "Directory to store state files";
    };

    overrideTimeout = mkOption {
      type = types.int;
      default = 300;
      description = "Time in seconds that manual override remains active";
    };

    temperatureThresholds = mkOption {
      type = types.listOf (types.submodule {
        options = {
          temp = mkOption {
            type = types.int;
            description = "Temperature threshold in Celsius";
          };
          level = mkOption {
            type = types.int;
            description = "Fan level to set at this temperature";
          };
        };
      });
      default = [
        { temp = 30; level = 0; }
        { temp = 40; level = 2; }
        { temp = 50; level = 4; }
        { temp = 60; level = 5; }
        { temp = 70; level = 6; }
        { temp = 999; level = 7; }
      ];
      description = "Temperature thresholds and corresponding fan levels";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.loq-fan-control = {
      description = "Lenovo LOQ Fan Control Service";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${loqFanControlWrapped}/bin/loq-fan-control --daemon";
        Restart = "always";
        RestartSec = "30s";
        KillMode = "process";
        ReadWritePaths = [ cfg.stateDir "/proc/acpi/ibm/fan" ];
        ReadOnlyPaths = [ "/sys" ];
        CapabilityBoundingSet = [ "CAP_DAC_OVERRIDE" "CAP_SYS_ADMIN" ];
        DevicePolicy = "closed";
        LockPersonality = true;
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectHome = true;
        ProtectKernelTunables = false;
        ProtectSystem = "strict";
        RestrictSUIDSGID = true;
      };
    };

    systemd.tmpfiles.rules = [
      "d '${cfg.stateDir}' 0750 root root -"
    ];

    boot.kernelModules = [ "thinkpad_acpi" ];
    boot.extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

    # Make the script available system-wide and ensure lm_sensors is installed
    environment.systemPackages = [ loqFanControlWrapped pkgs.lm_sensors ];
  };
}
