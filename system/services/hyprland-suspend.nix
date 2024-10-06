{
  config,
  pkgs,
  ...
}: let
  suspend = ./suspend-hyprland;
in {
  # Define the suspend service
  systemd.services.suspend-hyprland = {
    description = "Suspend Hyprland";
    before = ["systemd-suspend.service" "systemd-hibernate.service" "nvidia-suspend.service" "nvidia-hibernate.service"];
    wantedBy = ["systemd-suspend.service" "systemd-hibernate.service"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${suspend} suspend"; # Adjust the interpreter if necessary
    };
  };

  # Define the resume service
  systemd.services.resume-hyprland = {
    description = "Resume Hyprland";
    after = ["systemd-suspend.service" "systemd-hibernate.service" "nvidia-resume.service"];
    wantedBy = ["systemd-suspend.service" "systemd-hibernate.service"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${suspend} resume"; # Adjust the interpreter if necessary
    };
  };
}
